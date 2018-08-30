//
//  Serverhealth.swift
//  blissAppTest
//
//  Created by Faridullah on 8/30/18.
//  Copyright © 2018 Faridullah. All rights reserved.
//

import UIKit
import SwiftyJSON

class Serverhealth: NSObject {
    var status : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        status = json["status"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        status = aDecoder.decodeObject(forKey: "status") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        
    }

}
