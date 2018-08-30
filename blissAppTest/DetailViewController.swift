//
//  DetailViewController.swift
//  blissAppTest
//
//  Created by Faridullah on 8/30/18.
//  Copyright © 2018 Faridullah. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        self.title = "Detail"
        lblQuestion.text = questionDetail?.question
        lblpublish.text = questionDetail?.publishedAt
        if let image = questionDetail?.imageUrl {
            questionImge.loadImageWith(imgUrl: image, placeHolder: nil)
        }
        txtSelOption.addTarget(self, action: #selector(myTargetFunction), for: UIControlEvents.touchDown)
        txtSelOption.inputView = UIView();
    }
    
    
    @objc func myTargetFunction(textField: UITextField) {
        tbleOption.isHidden = false
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
