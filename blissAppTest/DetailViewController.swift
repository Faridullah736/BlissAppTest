//
//  DetailViewController.swift
//  blissAppTest
//
//  Created by Faridullah on 8/30/18.
//  Copyright © 2018 Faridullah. All rights reserved.
//

import UIKit
import MessageUI
import ReachabilitySwift

class DetailViewController: UIViewController,MFMailComposeViewControllerDelegate {
     let reachability = Reachability()
    @IBOutlet var questionImge: UIImageView!
    @IBOutlet var lblQuestion: UILabel!
    @IBOutlet var lblpublish: UILabel!
    @IBOutlet var txtSelOption: UITextField!
    @IBOutlet var tbleOption: UITableView!
    let cellId = "cellId"
    
    var questionDetail:QuestionModel? {
        didSet {
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tbleOption.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupUI()
    }


    
    func setupUI() {
        self.title = "Detail"
        lblQuestion.text = questionDetail?.question
        lblpublish.text = questionDetail?.publishedAt
        if let image = questionDetail?.imageUrl {
            questionImge.loadImageWith(imgUrl: image, placeHolder: nil)
        }
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        txtSelOption.addTarget(self, action: #selector(myTargetFunction), for: UIControlEvents.touchDown)
        txtSelOption.inputView = UIView();
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged), name: ReachabilityChangedNotification, object: reachability)
        do {
            try reachability?.startNotifier()
        }catch {
            print("could not start notifier")
        }
    }
    
    
    @objc func myTargetFunction(textField: UITextField) {
        tbleOption.isHidden = false
    }
    @objc func networkChanged(note:Notification) {
        let networkStatus = note.object as! Reachability
        if networkStatus.isReachable == true {
            self.dismiss(animated: true, completion: nil)
        }else{
            DispatchQueue.main.async {
                let Objc:noInternetViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "noInternet") as! noInternetViewController
                self.present(Objc, animated: true, completion: nil)
            }
        }
    }
    @IBAction func shareViaEmailAction(_ sender: Any) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
    
        composeVC.setSubject("Bliss Application Test")
        let body = "<p>This is a test. Check out the link</p> <a href=\"https://blissrecruitmentapi.docs.apiary.io/#\">Content Link</a>"
        composeVC.setMessageBody(body, isHTML: true)
      
        self.present(composeVC, animated: true, completion: nil)
    }

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
 
        controller.dismiss(animated: true, completion: nil)
    }


}
extension DetailViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (questionDetail?.choices.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = questionDetail?.choices[indexPath.row].choice
        
     
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        txtSelOption.text = questionDetail?.choices[indexPath.row].choice
        tableView.deselectRow(at: indexPath, animated: true)
        tbleOption.isHidden = true
    }
    
}
