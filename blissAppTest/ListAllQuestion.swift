//
//  ListAllQuestion.swift
//  blissAppTest
//
//  Created by Faridullah on 8/30/18.
//  Copyright © 2018 Faridullah. All rights reserved.
//

import UIKit
import ReachabilitySwift

class ListAllQuestion: UIViewController {
    let reachability = Reachability()
    @IBOutlet var tbleViewQuestion: UITableView!
    var arraySearchQuestion:Array<QuestionModel> = []
    var arrayAllQuestion:Array<QuestionModel> = []
     var isSlectedSearch : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        callWebServiceServerHealth()
    }


    
    func setupUI() {
        self.title = "All Questions"
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged), name: ReachabilityChangedNotification, object: reachability)
        do {
            try reachability?.startNotifier()
        }catch {
            print("could not start notifier")
        }
        
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ListAllQuestion: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        isSlectedSearch = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchBar.text!.count > 0{
            self.callWebServiceSearch(question: searchBar.text!)
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // start search
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        isSlectedSearch = false
        
    }
}
extension ListAllQuestion:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSlectedSearch == false ? arrayAllQuestion.count: arraySearchQuestion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:QuestionCell = tableView.dequeueReusableCell(withIdentifier: "question") as! QuestionCell
        if isSlectedSearch {
            let data = arraySearchQuestion[indexPath.row] as QuestionModel
            cell.questionData = data
        }else {
            let data = arrayAllQuestion[indexPath.row] as QuestionModel
            cell.questionData = data
        }
       
        if indexPath.row == arrayAllQuestion.count - 1 { // last cell
                   // more items to fetch
                loadItem() // increment `fromIndex` by 20 before server call
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
        let Objc:DetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detail") as! DetailViewController
        if isSlectedSearch {
             Objc.questionDetail = arraySearchQuestion[indexPath.row] as QuestionModel
        }else {
          Objc.questionDetail = arrayAllQuestion[indexPath.row] as QuestionModel
        }
        self.navigationController?.pushViewController(Objc, animated: true)
    }
    func loadItem() {
        self.callWebServiceListAllQuestions()
    }
}
