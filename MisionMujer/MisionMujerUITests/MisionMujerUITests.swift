//
//  MisionMujerUITests.swift
//  MisionMujerUITests
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import XCTest
class MisionMujerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHomeView() {
        // Get a reference to your app
        let app = XCUIApplication()
        sleep(5)
        let homeLatestTitle = app.staticTexts["homeLatestTitle"].label
        XCTAssertEqual(homeLatestTitle, "Calm yourself")
        
        let homeLatestDescription = app.staticTexts.element(matching: .any, identifier: "homeLatestDescription").label
        XCTAssertEqual(homeLatestDescription, "Less anxiety and more blissfulness")
        
        let homeLatestDuration = app.staticTexts.element(matching: .any, identifier: "homeLatestDuration").label
        XCTAssertEqual(homeLatestDuration, "111 min")
        
        let exploreCategoryLabel = app.staticTexts.element(matching: .any, identifier:"exploreCategoryLabel").firstMatch.label
        XCTAssertEqual(exploreCategoryLabel,  "Energize")
    }
    
    func testHomeViewClickLatest() {
        let app = XCUIApplication()
        sleep(5)

        app.scrollViews.otherElements.buttons["homeLatestDetailBtn"].tap()
        let teachingDetail = app/*@START_MENU_TOKEN@*/.staticTexts["teachingDetailLabel"]/*[[".staticTexts[\"7 min\"]",".staticTexts[\"teachingDetailLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label
        XCTAssertEqual(teachingDetail,  "111 min")
    }
    
    func testHomeViewClickCategory() {
        let app = XCUIApplication()
        sleep(5)

        let exploreCollection = XCUIApplication()/*@START_MENU_TOKEN@*/.otherElements["exploreView"]/*[[".scrollViews.otherElements[\"exploreView\"]",".otherElements[\"exploreView\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.collectionViews["exploreCategoryCollection"]
        exploreCollection.cells.otherElements.containing(.staticText, identifier:"Energize").element.tap()
        
        XCTAssert(app.tables.cells.count == 3)

        let firstResult = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Stop and be thankfull"]/*[[".cells[\"Stop and be thankfull, Gratitude and Thankfulness, Good Sleep, 2 min\"].staticTexts[\"Stop and be thankfull\"]",".staticTexts[\"Stop and be thankfull\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label
        XCTAssertEqual(firstResult, "Stop and be thankfull")

        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Stop and be thankfull"]/*[[".cells[\"Stop and be thankfull, Gratitude and Thankfulness, Good Sleep, 2 min\"].staticTexts[\"Stop and be thankfull\"]",".staticTexts[\"Stop and be thankfull\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let detailResult = app/*@START_MENU_TOKEN@*/.staticTexts["teachingDetailLabel"]/*[[".staticTexts[\"2 min\"]",".staticTexts[\"teachingDetailLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label
        XCTAssertEqual(detailResult, "166 min")
    }
    
    func testNewsView() {
        let app = XCUIApplication()
        app.tabBars.buttons["News"].tap()
        
        sleep(5)

        let newsTable = app.tables.element(matching: .any, identifier:"newsTableId")
        XCTAssert(newsTable.cells.count == 3)
        
        let cell = newsTable.cells.element(boundBy: 0)
        let cellLabelText = cell.staticTexts["newsTableLabel"].label
        XCTAssertEqual(cellLabelText, "Summer Festival")
        
        cell.tap()
        let descriptionTitleText = app.scrollViews.otherElements.staticTexts["Summer Festival"].label
        XCTAssertEqual(descriptionTitleText, "Summer Festival")
    }
    
    func testSearchView() {
        let app = XCUIApplication()
        app.tabBars.buttons["Search"].tap()
        
        sleep(3)
        
        let teachingTables = app.tables
        XCTAssert(teachingTables.cells.count == 7)

        teachingTables.searchFields["Search"].tap()
        app.typeText("Chakra")
        
        XCTAssert(teachingTables.cells.count == 3)
        
        teachingTables/*@START_MENU_TOKEN@*/.staticTexts["Second chakra"]/*[[".cells.staticTexts[\"Second chakra\"]",".staticTexts[\"Second chakra\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let teachingLabelDuration = app/*@START_MENU_TOKEN@*/.staticTexts["teachingDetailLabel"]/*[[".staticTexts[\"10 min\"]",".staticTexts[\"teachingDetailLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label
        XCTAssertEqual(teachingLabelDuration, "81 min")
    }
    
}
