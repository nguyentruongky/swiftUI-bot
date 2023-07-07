//
//  General.swift
//  Chat
//
//  Created by Ky Nguyen on 7/7/23.
//

import Foundation

func sleep(seconds: Double) async {
    do {
        try await Task.sleep(nanoseconds: UInt64(seconds) * 1000000000)
    } catch {
        // ignore
    }
}
