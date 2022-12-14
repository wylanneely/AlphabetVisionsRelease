//
//  RecognizedTextDataSource.swift
//  AlphabetVisionABCs
//
//  Created by Wylan L Neely on 8/25/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit
import Vision

protocol RecognizedTextDataSource: AnyObject {
    func addRecognizedText(recognizedText: [VNRecognizedTextObservation])
}

protocol WordTranscriptDelegate: AnyObject {
    func exctractCorrectWords(from transcript: String)
}
