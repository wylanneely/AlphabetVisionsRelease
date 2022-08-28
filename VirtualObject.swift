/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A `SCNReferenceNode` subclass for virtual objects placed into the AR scene.
*/

import Foundation
import SceneKit
import ARKit

class VirtualObject: SCNReferenceNode {
    
    /// The model name derived from the `referenceURL`.
    var modelName: String {
        let ref = referenceURL.lastPathComponent
            .replacingOccurrences(of: ".scn", with: "")
            .replacingOccurrences(of: ".usdz", with: "")
        return ref
    }
    
    /// The alignments that are allowed for a virtual object.
    var allowedAlignment: ARRaycastQuery.TargetAlignment {
        if modelName == "sticky note" {
            return .any
        } else {
            return .horizontal
        }
    }
    
    /// Rotates the first child node of a virtual object.
    /// - Note: For correct rotation on horizontal and vertical surfaces, rotate around
    /// local y rather than world y.
    var objectRotation: Float {
        get {
            return childNodes.first!.eulerAngles.y
        }
        set (newValue) {
            childNodes.first!.eulerAngles.y = newValue
        }
    }
    
    /// The object's corresponding ARAnchor.
    var anchor: ARAnchor?

    /// The raycast query used when placing this object.
    var raycastQuery: ARRaycastQuery?
    
    /// The associated tracked raycast used to place this object.
    var raycast: ARTrackedRaycast?
    
    /// The most recent raycast result used for determining the initial location
    /// of the object after placement.
    var mostRecentInitialPlacementResult: ARRaycastResult?
    
    /// Flag that indicates the associated anchor should be updated
    /// at the end of a pan gesture or when the object is repositioned.
    var shouldUpdateAnchor = false
    
    /// Stops tracking the object's position and orientation.
    /// - Tag: StopTrackedRaycasts
    func stopTrackedRaycast() {
        raycast?.stopTracking()
        raycast = nil
    }
    
    var isACurrentWordGoal: Bool {
        if GameMaster.global.wordGoalStrings.contains(modelName.lowercased()) {
            return true
        } else {
            return false
        }    }
    
}

extension VirtualObject {
    
    

    // MARK: Static Properties and Methods
    /// Loads all the model objects within `Models.scnassets`.
    static let availableObjects: [VirtualObject] = {
        let modelsURL = Bundle.main.url(forResource: "Models.scnassets", withExtension: nil)!
                
        let fileEnumerator = FileManager().enumerator(at: modelsURL, includingPropertiesForKeys: [])!
        return fileEnumerator.compactMap { element in
            let url = element as! URL
            if url.pathExtension == "usdz" {
                if let v = VirtualObject(url: url) {
                    if v.isACurrentWordGoal { return v } }
                }
                
            if url.pathExtension == "scn" && !url.path.contains("lighting")  {
                if let v = VirtualObject(url: url) {
                    if v.isACurrentWordGoal { return v} }
            }
        return nil}
    }()
    
    
    
    func filterWordGoalObjects(words: [WordGoal]) -> [VirtualObject] {
        var vObjcts: [VirtualObject] = []
        for word in words {
            for obj in VirtualObject.availableObjects {
                if word.word == obj.modelName {
                    vObjcts.append(obj)
                }
            }
        }
        return vObjcts
    }
    
    /// Returns a `VirtualObject` if one exists as an ancestor to the provided node.
    static func existingObjectContainingNode(_ node: SCNNode) -> VirtualObject? {
        if let virtualObjectRoot = node as? VirtualObject {
            return virtualObjectRoot
        }
        
        guard let parent = node.parent else { return nil }
        
        // Recurse up to check if the parent is a `VirtualObject`.
        return existingObjectContainingNode(parent)
    }
    
}
