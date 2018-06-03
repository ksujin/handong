//
//  FirstTableViewCell.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 22..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

   
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    func configure(menu : MenuVO){
        menuNameLabel.text =  menu.menuName
        priceLabel.text = String(menu.price)
        
    }
   

}
