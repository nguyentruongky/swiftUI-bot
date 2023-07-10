//
//  MicManager.swift
//  SpeechToDo
//
//  Created by Николай Никитин on 16.09.2022.
//

import Foundation
import AVFoundation

final class MicMonitor: ObservableObject {

    // MARK: - Properties
    private var audioRecorder: AVAudioRecorder
    private var timer: Timer?

    private var currentSample: Int
    private let numberOfSamples: Int

    @Published public var soundSamples: [Float]
    @Published public var duration: Double

    // MARK: - Init
    init(numberOfSamples: Int) {
        self.numberOfSamples = numberOfSamples > 0 ? numberOfSamples : 10
        soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        currentSample = 0
        duration = 0

        let audioSession = AVAudioSession.sharedInstance()
        /// Check permission for audio recording
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { granted in
                if !granted {
                    fatalError("We need audio recording for visualisation")
                }
            }
        }
        /// Make url path for saving audio
        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)

        /// Configure setting for recorder
        let recorderSetting: [String: Any] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recorderSetting)
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }

    // MARK: - Methods
    public func startMonitoring() {
        /// Enable to generate audio-level metering data by recorder
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        let interval = 0.01
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.audioRecorder.updateMeters()
            self.soundSamples[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
            self.currentSample = (self.currentSample + 1) % self.numberOfSamples
            self.duration += interval
        })
    }

    public func stopMonitoring() {
        timer?.invalidate()
        audioRecorder.stop()
    }

    // MARK: - DeInit
    deinit {
        timer?.invalidate()
        audioRecorder.stop()
    }
}
