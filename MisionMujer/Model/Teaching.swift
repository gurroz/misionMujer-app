//
//  Teaching.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
enum Teaching:Int {
    case startDay=1, goodSleep, firstChakra, secondChakra, thirdChakra, thanks, calm
    
    init() {
        self = .startDay
    }
    
    init?(number:Int)
    {
        switch number {
            case 1: self = .startDay
            case 2: self = .goodSleep
            case 3: self = .firstChakra
            case 4: self = .secondChakra
            case 5: self = .thirdChakra
            case 6: self = .thanks
            case 7: self = .calm
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
            case .startDay : return "Summer startDay"
            case .goodSleep : return "New Time available"
            case .firstChakra : return "Welcome new Teacher"
            case .secondChakra: return "Welcome new Teacher"
            case .thirdChakra: return "Welcome new Teacher"
            case .thanks: return "Welcome new Teacher"
            case .calm: return "Welcome new Teacher"
            }
        }
    }
    
    var description:String
    {
        get
        {
            switch self
            {
            case .startDay : return "The summer is here, and with this a new startDay. Renoun teachers and artist!"
            case .goodSleep : return "On every Thursday a new class will be open"
            case .firstChakra : return "To all newcomers and old staff"
            case .secondChakra: return "To all newcomers and old staff"
            case .thirdChakra: return "To all newcomers and old staff"
            case .thanks: return "To all newcomers and old staff"
            case .calm: return "To all newcomers and old staff"
            }
        }
    }
    
    var notes:String
    {
        get
        {
            switch self
            {
            case .startDay : return "Soak up the summer months at some of Melbourne's most exciting and diverse music and arts startDays. You don't have to travel hours into the countryside to get the full startDay experience; Melbourne's thriving live music scene means that the city is full of events packed with local bands and international talent. We've even got a startDay run entirely on solar power – we told you Melbourne's startDay offerings were diverse! Our top choices for summer combine stellar live music line-ups, art installations, light shows and boutique options for alfresco dining, so don your wristband – the startDay season is upon us. For more live music tips in Melbourne, check out our guide to the best places to see gigs every night of the week, and read about all the best upcoming gigs in Melbourne."
                
            case .goodSleep : return "Call now to book an initial one to one physio session. During this, we will assess your current issues and form goals on what you want to achieve. We will teach you how to activate your deep core using ultrasound imaging and will initiate you with the basic exercises you will be performing in the class."
                
            case .firstChakra : return "We’d like to warmly welcome all the newly-hired teachers to our wonderful learning institution for a new school year. We are so excited to have you all join our faculty. Our community of teachers continues to grow, but our mission statement always remains the same: we are here to serve, teach and help our students. I have also been instructed to read to you a recently-added, supplementary mission statement for the teachers. We hope everyone had a great summer because it’s time to get to work!"
            case .secondChakra:
                return "We’d like to warmly welcome all the newly-hired teachers to our wonderful learning institution for a new school year. We are so excited to have you all join our faculty. Our community of teachers continues to grow, but our mission statement always remains the same: we are here to serve, teach and help our students. I have also been instructed to read to you a recently-added, supplementary mission statement for the teachers. We hope everyone had a great summer because it’s time to get to work!"
            case .thirdChakra:
                return "We’d like to warmly welcome all the newly-hired teachers to our wonderful learning institution for a new school year. We are so excited to have you all join our faculty. Our community of teachers continues to grow, but our mission statement always remains the same: we are here to serve, teach and help our students. I have also been instructed to read to you a recently-added, supplementary mission statement for the teachers. We hope everyone had a great summer because it’s time to get to work!"
            case .thanks:
                return "We’d like to warmly welcome all the newly-hired teachers to our wonderful learning institution for a new school year. We are so excited to have you all join our faculty. Our community of teachers continues to grow, but our mission statement always remains the same: we are here to serve, teach and help our students. I have also been instructed to read to you a recently-added, supplementary mission statement for the teachers. We hope everyone had a great summer because it’s time to get to work!"
            case .calm:
                return "We’d like to warmly welcome all the newly-hired teachers to our wonderful learning institution for a new school year. We are so excited to have you all join our faculty. Our community of teachers continues to grow, but our mission statement always remains the same: we are here to serve, teach and help our students. I have also been instructed to read to you a recently-added, supplementary mission statement for the teachers. We hope everyone had a great summer because it’s time to get to work!"
            }
        }
    }
    
    var date:String
    {
        get
        {
            switch self
            {
            case .startDay : return "01/07/2018"
            case .goodSleep : return "01/08/2018"
            case .firstChakra : return "01/09/2018"
            case .secondChakra: return "01/09/2018"
            case .thirdChakra: return "01/09/2018"
            case .thanks: return "01/09/2018"
            case .calm: return "01/09/2018"
            }
        }
    }
    
    var category:String
    {
        get
        {
            switch self
            {
            case .startDay : return "Energize"
            case .goodSleep : return "GoodSleep"
            case .firstChakra : return "Chakras"
            case .secondChakra: return "Chakras"
            case .thirdChakra: return "Chakras"
            case .thanks: return "GoodSleep,Energize,Mindfulness"
            case .calm: return "Energize,GoodSleep,Mindfulness"
            }
        }
    }
    
    var duration:Int
    {
        get
        {
            switch self
            {
            case .startDay : return 300
            case .goodSleep : return 450
            case .firstChakra : return 600
            case .secondChakra: return 600
            case .thirdChakra: return 600
            case .thanks: return 150
            case .calm:  return 150
            }
        }
    }
    
    var type:String
    {
        get
        {
            switch self
            {
            case .startDay : return "audio"
            case .goodSleep : return  "audio"
            case .firstChakra : return  "video"
            case .secondChakra: return  "video"
            case .thirdChakra: return  "video"
            case .thanks: return  "audio"
            case .calm:  return  "audio"
            }
        }
    }
    
    var imageName:String
    {
        get
        {
//            let name = "teaching\(self.id)"
            let name = "dummy"
            return name
        }
    }
    
    
    static func getTeaching() ->[Teaching]
    {
        return [startDay, goodSleep, firstChakra, secondChakra, thirdChakra, thanks, calm]
    }
    
    static func getTeachingDictionary() ->[String:Teaching]
    {
        var teachingDictionary:[String:Teaching] = [:]
        for teaching in getTeaching() {
            teachingDictionary.updateValue(teaching, forKey: String(teaching.id))
        }
        
        return teachingDictionary
    }
}
