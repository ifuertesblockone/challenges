import Foundation
import XCTest

protocol Storage {
    func save(_ text: String)
}

final class OrderProcessor {
    var storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func process(text: String) {
        storage.save(text)
    }
}

final class CloudStorage: Storage {
    func save(_ text: String) {
        // Save the string to backend
        print("save \(text) from CloudStorage")
    }
}

let orderProcessor = OrderProcessor(storage: CloudStorage())

orderProcessor.process(text: "iPad mini")

class MockStorage: Storage {
    private var saveArgument: String?
    
    func save(_ text: String) {
        saveArgument = text
    }
    
    func getSaveArgument() -> String? {
        return saveArgument
    }
}

class OrderProcessorTests: XCTestCase {
    var storage: MockStorage!
    var sut: OrderProcessor!

    override func setUp() {
        super.setUp()
        storage = MockStorage()
        sut = OrderProcessor(storage: storage)
    }

    override func tearDown() {
        sut = nil
        storage = nil
        super.tearDown()
    }

    func test_ThereIsInformationToSave_Process_TheStorageSaveTheInformationProvided() {
        // Given
        let text = "MacBook Pro"
        
        // When
        sut.process(text: text)

        // Then
        guard let textToSave = storage.getSaveArgument() else {
            XCTFail("Text to save is missed")
            return
        }
        
        XCTAssertEqual(textToSave, text)
    }
}

OrderProcessorTests.defaultTestSuite.run()
