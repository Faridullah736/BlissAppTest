//
//  Choice.swift
//  blissAppTest
//
//  Created by Faridullah on 8/30/18.
//  Copyright © 2018 Faridullah. All rights reserved.
//  Created on August 30, 2018

import Foundation
import SwiftyJSON


class Choice : NSObject, NSCoding{

    var choice : String!
    var votes : Int!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        choice = json["choice"].stringValue
        votes = json["votes"].intValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()
        if choice != nil{
        	dictionary["choice"] = choice
        }
        if votes != nil{
        	dictionary["votes"] = votes
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		choice = aDecoder.decodeObject(forKey: "choice") as? String
		votes = aDecoder.decodeObject(forKey: "votes") as? Int
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if choice != nil{
			aCoder.encode(choice, forKey: "choice")
		}
		if votes != nil{
			aCoder.encode(votes, forKey: "votes")
		}

	}

}
