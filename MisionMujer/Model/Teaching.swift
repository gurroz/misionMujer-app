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
            case .startDay : return "Start your day"
            case .goodSleep : return "Get a good sleep"
            case .firstChakra : return "Let's work in the first chakra"
            case .secondChakra: return "Second chakra"
            case .thirdChakra: return "Third chakra"
            case .thanks: return "Stop and be thankfull"
            case .calm: return "Calm yourself"
            }
        }
    }
    
    var description:String
    {
        get
        {
            switch self
            {
            case .startDay : return "The first few minutes of your morning are the most important of your day."
            case .goodSleep : return "Healthy sleep habits can make a big difference in your quality of life"
            case .firstChakra : return "Activate the Root Chakra"
            case .secondChakra: return "What Is The Sacral Chakra?"
            case .thirdChakra: return "Solar Plexus Chakra"
            case .thanks: return "Gratitude and Thankfulness"
            case .calm: return "Less anxiety and more blissfulness"
            }
        }
    }
    
    var notes:String
    {
        get
        {
            switch self
            {
            case .startDay : return "The first few minutes of your morning are the most important of your day and can set the tone for positivity and productivity. Ideally, you have an app or clock that taps into your natural circadian rhythm and wakes you during your best time within a certain window. Getting jarred out of a deep REM slumber to the sound of a blaring alarm clock sets you up for a negative day brimming with fatigue and crankiness.But getting the right alarm clock is only part of the battle."
                
            case .goodSleep : return "Stick to a sleep schedule of the same bedtime and wake up time, even on the weekends. This helps to regulate your body's clock and could help you fall asleep and stay asleep for the night. Practice a relaxing bedtime ritual. A relaxing, routine activity right before bedtime conducted away from bright lights helps separate your sleep time from activities that can cause excitement, stress or anxiety which can make it more difficult to fall asleep, get sound and deep sleep or remain asleep. Sleep on a comfortable mattress and pillows. Make sure your mattress is comfortable and supportive. The one you have been using for years may have exceeded its life expectancy – about 9 or 10 years for most good quality mattresses. Have comfortable pillows and make the room attractive and inviting for sleep but also free of allergens that might affect you and objects that might cause you to slip or fall if you have to get up."
                
            case .firstChakra : return "The first chakra is associated with the following functions or behavioral characteristics: Security, safety. Survival, Basic needs (food, sleep, shelter, self-preservation, etc.). Physicality, physical identity and aspects of self. Grounding. Support and foundation for living our lives"
                
            case .secondChakra:
                return "The sacral chakra is associated with the realm of emotions. It’s the center of our feelings and sensations. It’s particularly active in our sexuality and the expression of our sensual and sexual desires."
                
            case .thirdChakra:
                return "The Third Chakra or the Solar plexus chakra is known as the Manipura Chakra in Sanskrit. ‘Mani’ stands for pearl or jewel and ‘pura’ stands for city. Thus, the Manipura Chakra is responsible for ‘pearls of wisdom’, well being, clarity and common sense in every individual. Experts call the Third Chakra the ‘self power chakra’- one’s self-confidence, self-discipline and the ability to achieve goals all come from it."
                
            case .thanks:
                return "The way to live an enriching and fulfilling life is to live with gratefulness. The key is to keep gratitude at the forefront of your life. When you focus your mind on how privileged you are, it makes it easy for you to want to bless other people and express your deep sense of appreciation toward other things."
                
            case .calm:
                return "When you’re anxious or angry, it can feel like every muscle in your body is tense (and they probably are). Practicing progressive muscle relaxation can help you calm down and center yourself. To do this, lie down on the floor with your arms out by your side. Make sure your feet aren’t crossed and your hands aren’t in fists. Start at your toes and tell yourself to release them. Slowly move up your body, telling yourself to release each part of your body until you get to your head."
            }
        }
    }
    
    var date:String
    {
        get
        {
            switch self
            {
            case .startDay : return "20/07/2018"
            case .goodSleep : return "15/08/2018"
            case .firstChakra : return "01/07/2018"
            case .secondChakra: return "08/09/2018"
            case .thirdChakra: return "12/08/2018"
            case .thanks: return "24/08/2018"
            case .calm: return "29/07/2018"
            }
        }
    }
    
    var category:[String]
    {
        get
        {
            switch self
            {
            case .startDay : return ["Energize"]
            case .goodSleep : return ["Good Sleep"]
            case .firstChakra : return ["Chakras"]
            case .secondChakra: return ["Chakras"]
            case .thirdChakra: return ["Chakras"]
            case .thanks: return ["Good Sleep","Energize","Mindfulness"]
            case .calm: return ["Energize","Good Sleep","Mindfulness"]
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
            let name = "teaching\(self.id)"
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
    
    static func getTeachingCategoryDictionary() ->[String:[Teaching]]
    {
        var teachingDictionary:[String:[Teaching]] = [:]
        for teaching in getTeaching() {
            let teachingCategories = teaching.category
            for category in teachingCategories {
                let categoryCleaned = category.replacingOccurrences(of: " ", with: "").lowercased()
                var actualList = teachingDictionary[categoryCleaned] ?? [Teaching]()
                actualList.append(teaching)
                
                teachingDictionary.updateValue(actualList, forKey: categoryCleaned)
            }
        }
        
        return teachingDictionary
    }
}
