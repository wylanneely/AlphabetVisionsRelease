/*
See LICENSE folder for this sample’s licensing information.

Abstract:
View controller from which to invoke the document scanner.
*/

import UIKit
import VisionKit
import Vision

class DocumentScanningViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static let otherContentsIdentifier = "toVisionResults"

    enum ScanMode: Int {
        case receipts
        case businessCards
        case other
    }
    
    var scanMode: ScanMode = .receipts
    var resultsViewController: (UIViewController & RecognizedTextDataSource)?
    var textRecognitionRequest = VNRecognizeTextRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: { (request, error) in
            guard let resultsViewController = self.resultsViewController else {
                print("resultsViewController is not set")
                return
            }
            if let results = request.results, !results.isEmpty {
                if let requestResults = request.results as? [VNRecognizedTextObservation] {
                    DispatchQueue.main.async {
                        resultsViewController.addRecognizedText(recognizedText: requestResults)
                    }
                }
            }
        })
        // This doesn't require OCR on a live camera feed, select accurate for more accurate results.
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = true
    }

    @IBAction func scan(_ sender: UIControl) {
        guard let scanMode = ScanMode(rawValue: sender.tag) else { return }
        self.scanMode = scanMode
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = self
        present(documentCameraViewController, animated: true)
    }
    
    func processImage(image: UIImage) {
        guard let cgImage = image.cgImage else {
            print("Failed to get cgimage from input image")
            return
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
        } catch {
            print(error)
        }
    }
    //MARK: - Tableview Delegate

    var wordGoals: [WordGoal] {
        return GameMaster.global.getCurrentWordGoals()
    }
    @IBOutlet weak var tableView: UITableView!
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "WordGoalTableViewCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "WordGoalTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return wordGoals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let wordGoalIndex = indexPath.row
        
        let wordGoal = wordGoals[wordGoalIndex]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WordGoalTableViewCell") as? WordGoalTableViewCell {
            cell.setWordGoal(wordGoal)
                return cell
            }
            
            return UITableViewCell()
    }
    
    
    
}

extension DocumentScanningViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        var vcID: String?
       
            vcID = DocumentScanningViewController.otherContentsIdentifier
        
        
        if let vcID = vcID {
            resultsViewController = storyboard?.instantiateViewController(withIdentifier: vcID) as? (UIViewController & RecognizedTextDataSource)
        }
        
        self.activityIndicator.startAnimating()
        controller.dismiss(animated: true) {
            DispatchQueue.global(qos: .userInitiated).async {
                for pageNumber in 0 ..< scan.pageCount {
                    let image = scan.imageOfPage(at: pageNumber)
                    self.processImage(image: image)
                }
                DispatchQueue.main.async {
                    if let resultsVC = self.resultsViewController {
                        self.navigationController?.pushViewController(resultsVC, animated: true)
                    }
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}
