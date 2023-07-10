//
//  ChatTests.swift
//  ChatTests
//
//  Created by Ky Nguyen on 7/11/23.
//

import XCTest
@testable import Chat

final class ChatViewModelTests: XCTestCase {

    func testSendMessage() {
        Task {
            let viewModel = ChatViewModel()
            viewModel.services = MockServices()

            let expectation = XCTestExpectation()
            let responseMessage = await viewModel.sendMessage("Hello")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {

                assert(viewModel.messages.count == 3)
                assert(viewModel.messages.last is MyMessage)
                assert(responseMessage == "Hello")

                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 1)
        }

    }

    struct MockServices: MessageServicesList {
        func sendMessage(_ message: String) async -> String {
            return "Hello"
        }
    }
}
