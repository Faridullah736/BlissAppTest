//
//  QuestionCell.swift
//  blissAppTest
//
//  Created by Faridullah on 8/30/18.
//  Copyright © 2018 Faridullah. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet var lblQuestion: UILabel!
    @IBOutlet var thumbImge: UIImageView!
    var questionData:QuestionModel? {
        didSet {
            updateUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateUI() {
        lblQuestion.text = questionData?.question
        if let image = questionData?.thumbUrl {
            thumbImge.loadImageWith(imgUrl: image, placeHolder: nil)
        }
    }
    func setupUI() {
//        thumbImge.layer.masksToBounds = false
//        thumbImge.layer.cornerRadius = thumbImge.frame.height/2
//        thumbImge.clipsToBounds = true
        thumbImge.setRounded()
    }
}
