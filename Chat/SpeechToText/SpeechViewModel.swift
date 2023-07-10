//
//  SpeechViewModel.swift
//  Chat
//
//  Created by Ky Nguyen on 7/10/23.
//

import Foundation
import SwiftUI

enum RecordStatus {
    case recording, processing, idle
}

class SpeechViewModel: ObservableObject {
    @Published var recordStatus = RecordStatus.idle
    @Published var transcript: String = ""
    let speechManager = SpeechManager()

    func stopRecording() {
        recordStatus = .processing
        speechManager.stopRecording()
    }
}
