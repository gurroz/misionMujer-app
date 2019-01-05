//
//  MisionMujerTests.swift
//  MisionMujerTests
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import XCTest
import SwiftyJSON

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
        var teachingDict: JSON = []
        var teaching = Teaching(json: teachingDict)
        XCTAssertNil(teaching)

        teachingDict = ["id": 6,
        "title": "Sleeping Habits",
        "published": "2018-12-29T10:09:19.000+0000",
        "type": "VIDEO",
        "cover": "https://misionmujers3.s3.amazonaws.com/category3.jpg",
        "length": 9946,
        "description": "6 Tips for healthy sleep",
        "content": "Stick to a sleep schedule of the same bedtime and wake up time, even on the weekends. This helps to regulate your body's clock and could help you fall asleep and stay asleep for the night.\nPractice a relaxing bedtime ritual. A relaxing, routine activity right before bedtime conducted away from bright lights helps separate your sleep time from activities that can cause excitement, stress or anxiety which can make it more difficult to fall asleep, get sound and deep sleep or remain asleep.\nIf you have trouble sleeping, avoid naps, especially in the afternoon. Power napping may help you get through the day, but if you find that you can't fall asleep at bedtime, eliminating even short catnaps may help.\nExercise daily. Vigorous exercise is best, but even light exercise is better than no activity. Exercise at any time of day, but not at the expense of your sleep.\nEvaluate your room. Design your sleep environment to establish the conditions you need for sleep. Your bedroom should be cool – between 60 and 67 degrees. Your bedroom should also be free from any noise that can disturb your sleep. Finally, your bedroom should be free from any light. Check your room for noises or other distractions. This includes a bed partner's sleep disruptions such as snoring. Consider using blackout curtains, eye shades, ear plugs, \"white noise\" machines, humidifiers, fans and other devices.\nSleep on a comfortable mattress and pillows. Make sure your mattress is comfortable and supportive. The one you have been using for years may have exceeded its life expectancy – about 9 or 10 years for most good quality mattresses. Have comfortable pillows and make the room attractive and inviting for sleep but also free of allergens that might affect you and objects that might cause you to slip or fall if you have to get up\nPages\n",
        "file": "https://misionmujers3.s3.amazonaws.com/meditationVideo1min.mp4",
        "categories": [[
            "id": 3,
            "name": "Good Sleep",
            "image": "https://misionmujers3.s3.amazonaws.com/category2.jpg"
            ]]
        ]
        teaching = Teaching(json: teachingDict)
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
        var newsDict: JSON = []
        var news = News(json: newsDict)
        XCTAssertNil(news)
        
        newsDict = [
            "id": 1,
            "title": "Trevors Hall new album",
            "published": "2018-12-28T12:23:23.000+0000",
            "description": "Is your practice playlist getting stale?",
            "content": "We've been fans of yogi-musician Trevor Hall since the beginning of his career creating wise-beyond-his-years music inspired by and to inspire yoga practice. (He played at Yoga Journal LIVE! Colorado in 2008!) Released today, the latest offering from this young musician, who once told YJ he sees each song as form of worship, had us at Track 1. (Just listen.)",
            "image": "https://misionmujers3.s3.amazonaws.com/trevor.jpg"
            ]
 
        news = News(json: newsDict)
        XCTAssertNotNil(news)
    }
    
    func testCategoriesMVCreation() {
        var categoryDict:JSON = []
        var category = Category(json: categoryDict)
        XCTAssertNil(category)

        categoryDict = [
            "id": 3,
            "name": "Good Sleep",
            "image": "https://misionmujers3.s3.amazonaws.com/category2.jpg"
            ]
        
        category = Category(json: categoryDict)

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
