//
//  ListAllQuestion.swift
//  blissAppTest
//
//  Created by Faridullah on 8/30/18.
//  Copyright © 2018 Faridullah. All rights reserved.
//

import UIKit

class ListAllQuestion: UIViewController {
    @IBOutlet var tbleViewQuestion: UITableView!
    var arraySearchQuestion:Array<QuestionModel> = []
    var arrayAllQuestion:Array<QuestionModel> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        callWebServiceServerHealth()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        self.title = "All Questions"
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
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
    
        
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
        
    }
}
extension ListAllQuestion:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayAllQuestion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:QuestionCell = tableView.dequeueReusableCell(withIdentifier: "question") as! QuestionCell
        let data = arrayAllQuestion[indexPath.row] as QuestionModel
        cell.questionData = data
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
        let Objc:DetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detail") as! DetailViewController
        Objc.questionDetail = arrayAllQuestion[indexPath.row] as QuestionModel
        self.navigationController?.pushViewController(Objc, animated: true)
    }
}
