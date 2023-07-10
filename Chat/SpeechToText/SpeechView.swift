//
//  ContentView.swift
//  SpeechToDo
//
//  Created by Николай Никитин on 16.09.2022.
//

import SwiftUI
import CoreData

struct SpeechView: View {
    @ObservedObject var viewModel: SpeechViewModel
    @StateObject var mic = MicMonitor()

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
                if viewModel.recordStatus == .processing {
                    Text("Please wait...")
                        .foregroundColor(.white)
                }

                if viewModel.recordStatus == .recording {
                    visualizerView()
                }
            }
            .frame(height: 100)
            .padding(.bottom, 40)
            .padding(.vertical, 20)
        }
        .background(Color("MyBubbleBackground"))
        .onAppear {
            viewModel.speechManager.checkPermissions()
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
        print(mic.soundSamples)
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func startRecording() {
        mic.startMonitoring()
        viewModel.recordStatus = .recording
        viewModel.speechManager.start { speechText in
            print(speechText ?? "No speech")
            withAnimation {
                viewModel.recordStatus = .idle
                viewModel.transcript = speechText ?? ""
            }
        }
        viewModel.speechManager.isRecording = true
    }

    private func stopRecording() {
        viewModel.stopRecording()
        mic.stopMonitoring()
    }

    private func normolizedSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2
        print(level)
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
    static var previews: some View {
        SpeechView(viewModel: SpeechViewModel()).preferredColorScheme(.dark)
    }
}
