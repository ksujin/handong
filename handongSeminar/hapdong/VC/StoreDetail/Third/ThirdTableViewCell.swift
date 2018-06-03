//
//  ThirdTableViewCell.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 22..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageView11: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    func configure(review : ReviewVO){
        writerLabel.text =  review.reviewWriter
        dateLabel.text = review.date
        imageView11.image = UIImage(named : review.image)
        contentLabel.text = review.reviewContent
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.bottomAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant : 20).isActive = true
    

    }

}
