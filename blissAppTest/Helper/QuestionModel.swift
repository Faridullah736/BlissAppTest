//
//  QuestionModel.swift
//  blissAppTest
//
//  Created by Faridullah on 8/30/18.
//  Copyright © 2018 Faridullah. All rights reserved.
//

import UIKit
import SwiftyJSON

class QuestionModel: NSObject,NSCoding {
    var choices : [Choice]!
    var id : Int!
    var imageUrl : URL!
    var publishedAt : String!
    var question : String!
    var thumbUrl : URL!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        choices = [Choice]()
        let choicesArray = json["choices"].arrayValue
        for choicesJson in choicesArray{
            let value = Choice(fromJson: choicesJson)
            choices.append(value)
        }
        id = json["id"].intValue
        imageUrl = json["image_url"].URL
        publishedAt = json["published_at"].stringValue
        question = json["question"].stringValue
        thumbUrl = json["thumb_url"].URL
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if choices != nil{
            var dictionaryElements = [[String:Any]]()
            for choicesElement in choices {
                dictionaryElements.append(choicesElement.toDictionary())
            }
            dictionary["choices"] = dictionaryElements
        }
        if id != nil{
            dictionary["id"] = id
        }
        if imageUrl != nil{
            dictionary["image_url"] = imageUrl
        }
        if publishedAt != nil{
            dictionary["published_at"] = publishedAt
        }
        if question != nil{
            dictionary["question"] = question
        }
        if thumbUrl != nil{
            dictionary["thumb_url"] = thumbUrl
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        choices = aDecoder.decodeObject(forKey: "choices") as? [Choice]
        id = aDecoder.decodeObject(forKey: "id") as? Int
        imageUrl = aDecoder.decodeObject(forKey: "image_url") as? URL
        publishedAt = aDecoder.decodeObject(forKey: "published_at") as? String
        question = aDecoder.decodeObject(forKey: "question") as? String
        thumbUrl = aDecoder.decodeObject(forKey: "thumb_url") as? URL
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if choices != nil{
            aCoder.encode(choices, forKey: "choices")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if imageUrl != nil{
            aCoder.encode(imageUrl, forKey: "image_url")
        }
        if publishedAt != nil{
            aCoder.encode(publishedAt, forKey: "published_at")
        }
        if question != nil{
            aCoder.encode(question, forKey: "question")
        }
        if thumbUrl != nil{
            aCoder.encode(thumbUrl, forKey: "thumb_url")
        }
        
    }

}
