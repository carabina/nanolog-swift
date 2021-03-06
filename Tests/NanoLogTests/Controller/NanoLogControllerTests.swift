// Copyright (C) 2018 Andrew Lord
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
// the License.
//
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//
// See the License for the specific language governing permissions and limitations under the License.

import Nimble
import XCTest

@testable import NanoLog

class NanoLogControllerTests: XCTestCase {
    private var controller: LogController!
    private let lane = LoggingLaneFake()

    override func setUp() {
        super.setUp()

        controller = NanoLogController()
        controller.addLoggingLane(lane)
    }
}

// MARK: - Tests
extension NanoLogControllerTests {
    func test_whenRegisterLoggingTag_thenTagSet() {
        let expectedTag = "some-expected-tag"

        controller.register(loggingTag: expectedTag)
        controller.logVerbose("Test", file: "File", function: "Function", line: 0)

        expect(self.lane.deliverTag).to(equal(expectedTag))
    }

    func test_whenAddLoggingLane_thenMessageDeliveredToIt() {
        let expectedLane = LoggingLaneFake()
        let expectedMessage = "a test message"

        controller.addLoggingLane(expectedLane)
        controller.logMessage(expectedMessage, withSeverity: LogSeverity.error, file: "", function: "", line: 0)

        expect(expectedLane.deliverMessage).to(equal(expectedMessage))
    }

    func test_whenRemoveAllLoggingLanes_thenMessageNotDeliveredToLane() {
        let lane = LoggingLaneFake()
        controller.addLoggingLane(lane)
        controller.addLoggingLane(NanoLoggingLane())

        controller.removeAllLoggingLanes()
        controller.logMessage("message", withSeverity: LogSeverity.error, file: "", function: "", line: 0)

        expect(lane.deliverMessage).to(beNil())
    }

    func test_whenLogVerbose_thenVerboseMessageDelivered() {
        let expectedMessage = "Some message"
        let expectedFile = "Some file"
        let expectedFunction = "Some function"
        let expectedLine = 10

        controller.logVerbose(expectedMessage, file: expectedFile, function: expectedFunction, line: expectedLine)

        expect(self.lane.deliverMessage).to(equal(expectedMessage))
        expect(self.lane.deliverSeverity?.label).to(equal(LogSeverity.verbose.label))
        expect(self.lane.deliverCallSite?.file).to(equal(expectedFile))
        expect(self.lane.deliverCallSite?.function).to(equal(expectedFunction))
        expect(self.lane.deliverCallSite?.line).to(equal(expectedLine))
    }

    func test_whenLogDebug_thenDebugMessageDelivered() {
        let expectedMessage = "Some message"
        let expectedFile = "Some file"
        let expectedFunction = "Some function"
        let expectedLine = 10

        controller.logDebug(expectedMessage, file: expectedFile, function: expectedFunction, line: expectedLine)

        expect(self.lane.deliverMessage).to(equal(expectedMessage))
        expect(self.lane.deliverSeverity?.label).to(equal(LogSeverity.debug.label))
        expect(self.lane.deliverCallSite?.file).to(equal(expectedFile))
        expect(self.lane.deliverCallSite?.function).to(equal(expectedFunction))
        expect(self.lane.deliverCallSite?.line).to(equal(expectedLine))
    }

    func test_whenLogInfo_thenInfoMessageDelivered() {
        let expectedMessage = "Some message"
        let expectedFile = "Some file"
        let expectedFunction = "Some function"
        let expectedLine = 10

        controller.logInfo(expectedMessage, file: expectedFile, function: expectedFunction, line: expectedLine)

        expect(self.lane.deliverMessage).to(equal(expectedMessage))
        expect(self.lane.deliverSeverity?.label).to(equal(LogSeverity.info.label))
        expect(self.lane.deliverCallSite?.file).to(equal(expectedFile))
        expect(self.lane.deliverCallSite?.function).to(equal(expectedFunction))
        expect(self.lane.deliverCallSite?.line).to(equal(expectedLine))
    }

    func test_whenLogWarning_thenWarningMessageDelivered() {
        let expectedMessage = "Some message"
        let expectedFile = "Some file"
        let expectedFunction = "Some function"
        let expectedLine = 10

        controller.logWarning(expectedMessage, file: expectedFile, function: expectedFunction, line: expectedLine)

        expect(self.lane.deliverMessage).to(equal(expectedMessage))
        expect(self.lane.deliverSeverity?.label).to(equal(LogSeverity.warning.label))
        expect(self.lane.deliverCallSite?.file).to(equal(expectedFile))
        expect(self.lane.deliverCallSite?.function).to(equal(expectedFunction))
        expect(self.lane.deliverCallSite?.line).to(equal(expectedLine))
    }

    func test_whenLogError_thenErrorMessageDelivered() {
        let expectedMessage = "Some message"
        let expectedFile = "Some file"
        let expectedFunction = "Some function"
        let expectedLine = 10

        controller.logError(expectedMessage, file: expectedFile, function: expectedFunction, line: expectedLine)

        expect(self.lane.deliverMessage).to(equal(expectedMessage))
        expect(self.lane.deliverSeverity?.label).to(equal(LogSeverity.error.label))
        expect(self.lane.deliverCallSite?.file).to(equal(expectedFile))
        expect(self.lane.deliverCallSite?.function).to(equal(expectedFunction))
        expect(self.lane.deliverCallSite?.line).to(equal(expectedLine))
    }

    func test_whenLogMessage_thenMessageWithSeverityDelivered() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.info
        let expectedFile = "Some file"
        let expectedFunction = "Some function"
        let expectedLine = 10

        controller.logMessage(expectedMessage,
                              withSeverity: expectedSeverity,
                              file: expectedFile,
                              function: expectedFunction,
                              line: expectedLine)

        expect(self.lane.deliverMessage).to(equal(expectedMessage))
        expect(self.lane.deliverSeverity?.label).to(equal(expectedSeverity.label))
        expect(self.lane.deliverCallSite?.file).to(equal(expectedFile))
        expect(self.lane.deliverCallSite?.function).to(equal(expectedFunction))
        expect(self.lane.deliverCallSite?.line).to(equal(expectedLine))
    }
}

#if os(Linux)
extension NanoLogControllerTests {
    static var allTests = [
        ("test_whenRegisterLoggingTag_thenTagSet", test_whenRegisterLoggingTag_thenTagSet),
        ("test_whenAddLoggingLane_thenMessageDeliveredToIt", test_whenAddLoggingLane_thenMessageDeliveredToIt),
        ("test_whenRemoveAllLoggingLanes_thenMessageNotDeliveredToLane", test_whenRemoveAllLoggingLanes_thenMessageNotDeliveredToLane),
        ("test_whenLogVerbose_thenVerboseMessageDelivered", test_whenLogVerbose_thenVerboseMessageDelivered),
        ("test_whenLogDebug_thenDebugMessageDelivered", test_whenLogDebug_thenDebugMessageDelivered),
        ("test_whenLogInfo_thenInfoMessageDelivered", test_whenLogInfo_thenInfoMessageDelivered),
        ("test_whenLogWarning_thenWarningMessageDelivered", test_whenLogWarning_thenWarningMessageDelivered),
        ("test_whenLogError_thenErrorMessageDelivered", test_whenLogError_thenErrorMessageDelivered),
        ("test_whenLogMessage_thenMessageWithSeverityDelivered", test_whenLogMessage_thenMessageWithSeverityDelivered)
    ]
}
#endif
