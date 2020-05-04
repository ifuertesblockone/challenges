//
//  BlockOneiOSEOSUITests.swift
//  BlockOneiOSEOSUITests
//
//  Created by Henry Bautista on 27/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import XCTest

class BlockOneiOSEOSUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testShowListView() {
        let app = XCUIApplication()
        app.launch()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
             
            // Swipe left three times to go through the pages
            app.buttons["toList"].tap()

            app.swipeUp()
            app.swipeDown()
            // Onboarding should no longer be displayed
            XCTAssertTrue(app.isDisplayingHomeView)
        }
    }
    
    func testShowBlockDetailView() {
        let app = XCUIApplication()
        app.launch()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
             XCTAssertTrue(app.isDisplayingHomeView)

            // Swipe left three times to go through the pages
            app.buttons["toList"].tap()
            
            XCTAssertFalse(app.isDisplayingHomeView)
            XCTAssertTrue(app.isDisplayingListView)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                app.cells.buttons["Detail"].tap()
                
                XCTAssertFalse(app.isDisplayingListView)
                XCTAssertTrue(app.isDisplayingBlockDetailView)
                
            }
        }
    }
}

extension XCUIApplication {
    var isDisplayingHomeView: Bool {
        return otherElements["HomeView"].exists
    }
    
    var isDisplayingListView: Bool {
        return otherElements["ListView"].exists
    }
    
    var isDisplayingBlockDetailView: Bool {
        return otherElements["BlockDetailView"].exists
    }
}
