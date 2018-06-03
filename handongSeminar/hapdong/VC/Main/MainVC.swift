//
//  MainVC.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    var selectedCategory = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    var navigationTitle : String  = ""
    
    @IBAction func frameMove(_ sender: UIButton) {
        
        if sender.tag == 0 {
            selectedCategory = 101
            
        } else if sender.tag == 1 {
        
            selectedCategory = 102
            
        } else if sender.tag == 2 {
            selectedCategory = 103
           
        } else {
          
            selectedCategory = 104
          
        }
        if let MenuDetailTVC = self.storyboard?.instantiateViewController(withIdentifier:"MenuDetailTVC") as? MenuDetailTVC {
          
            MenuDetailTVC.selectedCategory = self.selectedCategory
           
            self.navigationController?.pushViewController(MenuDetailTVC, animated: true)
        }
    }
    

}
