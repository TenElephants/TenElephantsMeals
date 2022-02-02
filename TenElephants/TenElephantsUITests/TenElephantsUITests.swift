//
//  TenElephantsUITests.swift
//  TenElephantsUITests
//
//  Created by Дарья Домрачева on 02.02.2022.
//

import XCTest

class TenElephantsUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {}
    
    func testTrendsOpenCloseRecipes() throws {
        let collectionViewsQuery = app.collectionViews

        // go to recipe in horizontal section
        collectionViewsQuery.scrollViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        let elementsQuery = app.scrollViews.otherElements

        // check buttons and labels
        XCTAssertTrue(elementsQuery.staticTexts["Ingredients"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Recipe"].exists)
        XCTAssert(app.buttons["Close"].exists)
        XCTAssert(app.buttons["love"].exists)
        
        // go back
        app.buttons["Close"].tap()
        
        // check that cells reappeared
        XCTAssertTrue(collectionViewsQuery.scrollViews.children(matching: .cell).count > 0)
        XCTAssertTrue(collectionViewsQuery.children(matching: .cell).count > 0)
    }
    
    func testTrendsInitialPage() throws {
        // check trends page labels and cells
        let trendsLabel = app.navigationBars["Trends"].staticTexts["Trends"]
        let hotRecipesLabel = app.collectionViews.staticTexts["Hot recipes"]
        XCTAssertTrue(trendsLabel.exists)
        XCTAssertTrue(hotRecipesLabel.exists)
        XCTAssertTrue(app.collectionViews.scrollViews.children(matching: .cell).count > 0) // now it's 2
        XCTAssertTrue(app.collectionViews.children(matching: .cell).count > 0) // now it's 3
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
