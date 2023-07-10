//
//  ContentView.swift
//  SpeechToDo
//
//  Created by Николай Никитин on 16.09.2022.
//

import SwiftUI
import CoreData

enum RecordStatus {
    case recording, processing, idle
}

struct SpeechView: View {
    @Binding var recording: Bool
    @Binding var transcript: String
    @State var isProcessingText: Bool = false
    @ObservedObject var mic = MicMonitor(numberOfSamples: 30)
    let speechManager = SpeechManager()

    // MARK: - View Body
    var body: some View {
        VStack {
            HStack {
                Text(durationString())
                    .foregroundColor(.white)
                Spacer()
                Text("Tap to stop recording")
                    .foregroundColor(.white)
            }
            .padding()

            VStack {
                if isProcessingText {
                    Text("Please wait...")
                        .foregroundColor(.white)
                } else {
                    visualizerView()
                }
            }
            .frame(height: 100)
            .padding(.bottom, 40)
            .padding(.vertical, 20)
        }
        .background(Color(hex: "#2F78E3")!)
        .onAppear {
            speechManager.checkPermissions()
            startRecording()
        }
        .onTapGesture {
            stopRecording()
        }
    }

    private func durationString() -> String {
        let duration = Int(mic.duration)
        let minutes = (duration % 3600) / 60
        let seconds = (duration % 3600) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func startRecording() {
        mic.startMonitoring()
        speechManager.start { speechText in
            guard let text = speechText else {
                withAnimation {
                    recording = false
                    transcript = ""
                }
                return
            }
            print(text)
            withAnimation {
                transcript = text
                recording = false
            }
        }
        speechManager.isRecording = true
    }

    private func stopRecording() {
        isProcessingText = true
        mic.stopMonitoring()
        speechManager.stopRecording()
        speechManager.isRecording = false
    }

    private func normolizedSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2
        return CGFloat(level * 4)
    }

    private func visualizerView() -> some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(mic.soundSamples, id: \.self) { level in
                    VisualBarView(value: normolizedSoundLevel(level: level))
                }
            }
        }
    }
}

struct SpeechView_Previews: PreviewProvider {
    @State static var isRecording = false
    @State static var transcript = ""
    @State static var isProcessingText: Bool = false
    static var previews: some View {
        SpeechView(recording: $isRecording,
                   transcript: $transcript,
                   isProcessingText: isProcessingText
        ).preferredColorScheme(.dark)
    }
}
