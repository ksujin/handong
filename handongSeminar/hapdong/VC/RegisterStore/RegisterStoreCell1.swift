//
//  RegisterStoreTVC0.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 6..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation
import UIKit

class RegisterStoreCell1 : UITableViewCell {
    
    @IBOutlet weak var storeTypeTextField: UITextField!
    @IBOutlet weak var storeNameTextField: UITextField!
    @IBOutlet weak var storeExplainTextField: UITextField!
    @IBOutlet weak var storeImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        storeImageView.isUserInteractionEnabled = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


