//
//  Extensions.swift
//  blissAppTest
//
//  Created by Faridullah on 8/30/18.
//  Copyright © 2018 Faridullah. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher
import SwiftyJSON

class Extensions: NSObject {
    
    //MARK:- Progress view for main activity
    static var indicatorCount = 0
    class func showProgress(title:String) {
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 15))
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setBackgroundColor(.black)
//        SVProgressHUD.setBackgroundLayerColor(.black)
        indicatorCount += 1
        if indicatorCount == 1 {
            SVProgressHUD.show(withStatus: title)
        }
        
    
    }
    
    class func hideProgress() {
        indicatorCount -= 1
        if indicatorCount < 0 {
            indicatorCount = 0
        }
        
        if indicatorCount == 0 {
            SVProgressHUD.dismiss()
        }
    }
    
}
extension UIImageView {
    func loadImageWith(imgUrl:URL?, placeHolder:UIImage?) {
        let imgPlaceHolder = (placeHolder != nil) ? placeHolder! : UIImage(named: "bitmap")
        self.kf.indicatorType = .activity
        //[.transition(ImageTransition.fade(0.5)), .forceTransition]
        self.kf.setImage(with: imgUrl, placeholder: imgPlaceHolder, options: nil, progressBlock: { (progress, total) in
            //
        }, completionHandler: { (image, error, cache, url) in
            //
        })
    }
    func setRounded() {
        let radius = (self.frame.height) / 4
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}

extension ListAllQuestion {
    func callWebServiceServerHealth(){
        Extensions.showProgress(title: "Checking Server health....")
        let url:String=Endpoint.Severhealth.urlString()
        
        _ = WebServiceManager.call(requestMethod: .get, serviceURL: url, params: nil, includeAccessToken: true, completion: { (response, error) in
            
            if (response != nil) {
                if (response?.response?.statusCode == ServerResponseStatusCode.kOK) && (response!.result.value != nil) {
                    Extensions.hideProgress()
                    let responseData = JSON(response!.result.value!)
                    let result = Serverhealth(fromJson:responseData)
                    if result.status == "OK" {
                        self.callWebServiceListAllQuestions()
                    }else {
                        let alertController = UIAlertController(title: "BlissAppTest", message: "Server health not OK!", preferredStyle: .alert)
                        let retry = UIAlertAction(title: "Retry Action", style: .default) { (action:UIAlertAction) in
                            self.callWebServiceServerHealth()
                        }
                        alertController.addAction(retry)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                } else if response?.response?.statusCode == ServerResponseStatusCode.kExpiredToken {
                    // Extension.showSessionExpiredAndOpenLogin(parentVC: self)
                } else if error != nil {
                    
                    print(error?.localizedDescription ?? "")
                } else {
                    if (response?.result.isFailure == true){
                        print("Request Timeout")
                        return
                    }
                    var responseData = JSON(response?.result.value ?? "")
                    let message:String? = (responseData != nil) ? responseData[DateResponseKey.kMessage].stringValue : nil
                    if message != nil {
                        
                        print("\(message!)")
                    } else {
                        
                        print("\(String(describing: response?.result.description))")
                    }
                }
            } else {
                
                print("\((error?.localizedDescription) ?? "")")
            }
        })
        
    }
    func callWebServiceListAllQuestions(){
         Extensions.showProgress(title: "Getting Questions....")
        let url:String=Endpoint.ListAllQuestions.urlString()
        
        _ = WebServiceManager.call(requestMethod: .get, serviceURL: url, params: nil, includeAccessToken: true, completion: { (response, error) in
            
            if (response != nil) {
                if (response?.response?.statusCode == ServerResponseStatusCode.kOK) && (response!.result.value != nil) {
                    Extensions.hideProgress()
                    self.arrayAllQuestion.removeAll()
                    let responseData = JSON(response!.result.value!).arrayValue
                    
                    //                    let resultData = responseData[DateResponseKey.kResult].arrayValue
                    for jsonUnit in responseData {
                        self.arrayAllQuestion.append(QuestionModel(fromJson:jsonUnit))
                    }
                    self.tbleViewQuestion.reloadData()
                    //                    print(resultData)
                    
                    
                    
                } else if response?.response?.statusCode == ServerResponseStatusCode.kExpiredToken {
                    // Extension.showSessionExpiredAndOpenLogin(parentVC: self)
                } else if error != nil {
                    
                    print(error?.localizedDescription ?? "")
                } else {
                    if (response?.result.isFailure == true){
                        print("Request Timeout")
                        return
                    }
                    var responseData = JSON(response?.result.value ?? "")
                    let message:String? = (responseData != nil) ? responseData[DateResponseKey.kMessage].stringValue : nil
                    if message != nil {
                        
                        print("\(message!)")
                    } else {
                        
                        print("\(String(describing: response?.result.description))")
                    }
                }
            } else {
                
                print("\((error?.localizedDescription) ?? "")")
            }
        })
        
    }
}

extension DetailViewController {
    
}
