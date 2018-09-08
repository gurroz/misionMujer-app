//
//  News.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
enum News:Int {
    case festival=1, newClassTime, newTeacher
    
    init() {
        self = .festival
    }
    
    init?(number:Int)
    {
        switch number {
        case 1 : self = .festival
        case 2: self = .newClassTime
        case 3: self = .newTeacher
        default: return nil
        }
    }
    
    var id:Int {
        get{
            return self.rawValue
        }
    }
    
    var title:String
    {
        get
        {
            switch self
            {
            case .festival : return "Summer Festival"
            case .newClassTime : return "New Time available"
            case .newTeacher : return "Welcome new Teacher"
            }
        }
    }
    
    var description:String
    {
        get
        {
            switch self
            {
            case .festival : return "The summer is here, and with this a new festival. Renoun teachers and artist!"
            case .newClassTime : return "On every Thursday a new class will be open"
            case .newTeacher : return "To all newcomers and old staff"
            }
        }
    }
    
    var content:String
    {
        get
        {
            switch self
            {
            case .festival : return "Soak up the summer months at some of Melbourne's most exciting and diverse music and arts festivals. You don't have to travel hours into the countryside to get the full festival experience; Melbourne's thriving live music scene means that the city is full of events packed with local bands and international talent. We've even got a festival run entirely on solar power – we told you Melbourne's festival offerings were diverse! Our top choices for summer combine stellar live music line-ups, art installations, light shows and boutique options for alfresco dining, so don your wristband – the festival season is upon us. For more live music tips in Melbourne, check out our guide to the best places to see gigs every night of the week, and read about all the best upcoming gigs in Melbourne."
                
            case .newClassTime : return "Call now to book an initial one to one physio session. During this, we will assess your current issues and form goals on what you want to achieve. We will teach you how to activate your deep core using ultrasound imaging and will initiate you with the basic exercises you will be performing in the class."
                
            case .newTeacher : return "We’d like to warmly welcome all the newly-hired teachers to our wonderful learning institution for a new school year. We are so excited to have you all join our faculty. Our community of teachers continues to grow, but our mission statement always remains the same: we are here to serve, teach and help our students. I have also been instructed to read to you a recently-added, supplementary mission statement for the teachers. We hope everyone had a great summer because it’s time to get to work!"
            }
        }
    }
    
    var date:String
    {
        get
        {
            switch self
            {
            case .festival : return "01/07/2018"
            case .newClassTime : return "01/08/2018"
            case .newTeacher : return "01/09/2018"
            }
        }
    }
    
    var imageName:String
    {
        get
        {
            let name = "news\(self.id)"
            return name
        }
    }
    
    
    static func getNews() ->[News]
    {
        return [festival, newClassTime, newTeacher]
    }
    
    static func getNewsDictionary() ->[String:News]
    {
        var newsDictionary:[String:News] = [:]
        for news in getNews() {
            newsDictionary.updateValue(news, forKey: String(news.id))
        }
        
        return newsDictionary
    }
}
