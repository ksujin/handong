//
//  MenuDetailCell.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import Kingfisher
class MenuDetailCell: UITableViewCell {
    
    @IBOutlet weak var storeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var ownerReplyCountLabel: UILabel!
    @IBOutlet weak var simpleMenuLabel: UILabel!
    
    func configure(store : Store){
      
        nameLabel.text = store.storeName
        rankLabel.text = "5.0"
        reviewCountLabel.text = "12"
        ownerReplyCountLabel.text = "12"
        simpleMenuLabel.text = store.storeContent
        
        if let url = URL(string: gsno(store.storePhoto)){
            self.storeImageView.kf.setImage(with: url)
        } else {
            self.storeImageView.image = #imageLiteral(resourceName: "star")
        }
        
       /* let storeIdx: Int
        let storeName: String
        let storeCategory: Int
        let storePhoto : String?
        let storeContent: String?
        let userIdx : Int*/
        
       
        
    }
    
    //cell 초기화
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        storeImageView.layer.cornerRadius = storeImageView.layer.frame.width/2
        storeImageView.layer.masksToBounds = true
        
        
        
    }
    

}
