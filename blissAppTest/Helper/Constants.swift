//
//  Constants.swift
//  blissAppTest
//
//  Created by Faridullah on 8/30/18.
//  Copyright © 2018 Faridullah. All rights reserved.
//

import UIKit



struct UserDefaultKeys {
    static let kAccessToken = "kAccessToken"
    static let kLoginType = "kLoginType"
    static let kSessionToken = "kSessionToken"
    
    static let kStoredDataForUsers = "kStoredDataForUsers"
    static let kCheckInForUser = "kCheckInForUser"
    
    static let kRemotePushToken = "kRemotePushToken"
    static let kIsRemotePushTokenRegistered = "kIsRemotePushTokenRegistered"
    
    static let kReceivedReferralCode = "kReceivedReferralCode"
    
    
}





struct DateResponseKey {
    static let kResult = "items"
    static let kUser = "user"
    static let kMessage = "message"
  
}



struct ServerResponseStatusCode {
    static let kOK                  = 200
    static let kExpiredToken        = 400
}

enum CustomBool:Int {
    case No = 0
    case Yes = 1
    case Undefined = 3
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPHONE_4_OR_LESS  = ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_7          = IS_IPHONE_6
    static let IS_IPHONE_7P         = IS_IPHONE_6P
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO_9_7      = IS_IPAD
    static let IS_IPAD_PRO_12_9     = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

class Constants: NSObject {
    
}
