//
//  WebServiceManager.swift
//  blissAppTest
//
//  Created by Faridullah on 8/30/18.
//  Copyright © 2018 Faridullah. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import ReachabilitySwift

#if DEBUG

    let serverBaseURL:String = "https://private-bbbe9-blissrecruitmentapi.apiary-mock.com/"

#else
    let serverBaseURL:String = "https://private-bbbe9-blissrecruitmentapi.apiary-mock.com/"
#endif




enum Endpoint {
    case Severhealth
    case ListAllQuestions
    case updateQuestion(questionId:Int)
    case QuestionFilter(questionFltr:String)
    
    
    func urlString() -> String {
        switch self {
        case .Severhealth:
            return serverBaseURL + "health"
            
        case .ListAllQuestions:
            return serverBaseURL + "questions?limit=10&offset=10"
            
        case .QuestionFilter(questionFltr: let qFltr):
            return serverBaseURL + "questions?question_filter=\(qFltr)"
        case .updateQuestion(questionId: let qId):
            return serverBaseURL + "questions/\(qId)"
       
            
        default:
            fatalError("URL endpoint undefined")
        }
    }
}


class WebServiceManager: NSObject {
    
    typealias ServiceResult = (_ responseData:DataResponse<Any>?, _ error:Error?) -> ()
    
    
    class func call(requestMethod:HTTPMethod, serviceURL:String, params:[String: AnyObject]?, includeAccessToken:Bool = true, completion:@escaping ServiceResult) -> DataRequest? {
        
        let reachability = Reachability()
        if reachability?.isReachable == false {
            let userInfo: [NSObject : AnyObject] =
                [
                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Reachability error", value: "Network unavailable", comment: "") as AnyObject,
                    NSLocalizedFailureReasonErrorKey as NSObject : NSLocalizedString("Reachability Error", value: "Network unavailable", comment: "") as AnyObject
            ]
            let err = NSError(domain: "Error Description", code: 3000, userInfo: userInfo as? [String : Any])
            completion(nil, err)
            return nil
        }
        
        var headers : HTTPHeaders? = nil
        headers = ["Content-Type" : "application/json"]
       
        
        return Alamofire.request(serviceURL, method: requestMethod, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseData) in
            completion(responseData, nil)
        }
    }
    
    class func call(requestMethod:HTTPMethod, serviceURL:String, params:[String: AnyObject]?, multipartData:[String: AnyObject], includeAccessToken:Bool = true, completion:@escaping ServiceResult) {
        
        let reachability = Reachability()
        if reachability?.isReachable == false {
            let userInfo: [NSObject : AnyObject] =
                [
                    NSLocalizedDescriptionKey as NSObject :  NSLocalizedString("Reachability error", value: "Network unavailable", comment: "") as AnyObject,
                    NSLocalizedFailureReasonErrorKey as NSObject : NSLocalizedString("Reachability Error", value: "Network unavailable", comment: "") as AnyObject
            ]
            let err = NSError(domain: "Error Description", code: 3000, userInfo: userInfo as? [String : Any])
            completion(nil, err)

            return
        }
        
        var headers : HTTPHeaders? = nil
        headers = ["Content-Type" : "application/json"]
     
        let URL = try! URLRequest(url: serviceURL, method: requestMethod, headers: headers)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            // code
            for (key, value) in multipartData {
                if let imageData = value as? Data {
                    multipartFormData.append(imageData, withName: key, fileName: "file.jpeg", mimeType: "image/jpeg")
                }
            }
            
            for (key, value) in params! {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
        }, with: URL, encodingCompletion: { (result) in
            // code
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    completion(response, nil)
                }
                
                case .failure(let encodingError):
                    completion(nil, encodingError)
            }
        })
    }
    
    class func cancel(request:Any?) {
        if let obj = request as? DataRequest {
            obj.cancel()
        }
    }
}
