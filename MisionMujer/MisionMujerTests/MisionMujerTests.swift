//
//  MisionMujerTests.swift
//  MisionMujerTests
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import XCTest
@testable import MisionMujer

class MisionMujerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTeachingsCRUD() {
        saveTeaching()
        updateTeaching()
        deleteTeaching()
    }
    
    func saveTeaching() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var teachingDict = [String: Any]()
        var teaching = Teaching(json: teachingDict as NSDictionary)
        XCTAssertNil(teaching)

        teachingDict.updateValue(3, forKey: "id")
        teachingDict.updateValue("Testing title", forKey: "title")
        teachingDict.updateValue("Testing description", forKey: "description")
        teachingDict.updateValue("Testing content", forKey: "content")
        teachingDict.updateValue("2018-10-01T12:08:06.000+0000", forKey: "published")
        teachingDict.updateValue("AUDIO", forKey: "type")
        teachingDict.updateValue([], forKey: "categories")
        teachingDict.updateValue(120, forKey: "length")
        teachingDict.updateValue("img", forKey: "cover")
        teachingDict.updateValue("file", forKey: "file")

        teaching = Teaching(json: teachingDict  as NSDictionary)
        XCTAssertNotNil(teaching)
        
        TeachingService.sharedInstance.persistTeaching(teaching: teaching!, onSuccess: { _ in })
        
        let teachings = TeachingService.sharedInstance.getPersistedTeachingList()
        XCTAssert(teachings.count == 1)
    }
    
    func updateTeaching() {
        var teachings = TeachingService.sharedInstance.getPersistedTeachingList()
        XCTAssert(teachings.count == 1)
        
        TeachingService.sharedInstance.updateTeachingStatistics(teaching: teachings[0])
        
        teachings = TeachingService.sharedInstance.getPersistedTeachingList()
        XCTAssert(teachings.count == 1)
        
        XCTAssert(teachings[0].views == 1)
    }
    
    func deleteTeaching() {
        var teachings = TeachingService.sharedInstance.getPersistedTeachingList()
        XCTAssert(teachings.count == 1)
        
        TeachingService.sharedInstance.deletePersistedTeaching(teaching: teachings[0])
        
        teachings = TeachingService.sharedInstance.getPersistedTeachingList()
        XCTAssert(teachings.count == 0)
    }
    
    func testNewsMVCreation() {
        var newsDict = [String: Any]()
        var news = News(json: newsDict as NSDictionary)
        XCTAssertNil(news)
        
        newsDict.updateValue(3, forKey: "id")
        newsDict.updateValue("TitleTest", forKey: "title")
        newsDict.updateValue("Img", forKey: "description")
        newsDict.updateValue("Content", forKey: "content")
        newsDict.updateValue("2018-10-01T12:08:06.000+0000", forKey: "published")
        newsDict.updateValue("Img", forKey: "image")

        news = News(json: newsDict as NSDictionary)
        XCTAssertNotNil(news)
    }
    
    func testCategoriesMVCreation() {
        var categoryDict = [String: Any]()
        var category = Category(json: categoryDict as NSDictionary)
        XCTAssertNil(category)

        categoryDict.updateValue(3, forKey: "id")
        categoryDict.updateValue("CatName", forKey: "name")
        categoryDict.updateValue("Img", forKey: "image")
        category = Category(json: categoryDict as NSDictionary)
        
        XCTAssertNotNil(category)
    }
    
    func testNewsAPI() {
        let newsAPI = NewsAPI(nextHandler: nil)
        let promise = expectation(description: "News obtained")

        newsAPI.getAllNews(onCompleted: { news in
            promise.fulfill()
            XCTAssert((news?.count)! > 0)
        })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCategoryAPI() {
        let categoryAPI = CategoryAPI(nextHandler: nil)
        let promise = expectation(description: "Categories obtained")
        
        categoryAPI.getCategories(onCompleted: { categories in
            promise.fulfill()
            XCTAssert((categories?.count)! > 0)
        })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testTeachingAPI() {
        let teachingsAPI = TeachingAPI(nextHandler: nil)
        let promise = expectation(description: "Teachings obtained")
        
        teachingsAPI.getAllTeachings(onCompleted: { teachings in
            promise.fulfill()
            XCTAssert((teachings?.count)! > 0)
        })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
