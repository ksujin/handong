//
//  MainVC.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class MainVC: UIViewController, APIService {
    
    var stores : [Store] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    var navigationTitle : String  = ""
    
    @IBAction func frameMove(_ sender: UIButton) {
        
        if sender.tag == 0 {
            navigationTitle = "한식"
           // storeBoardInit(url: url("/store/list/101"))
            
        } else if sender.tag == 1 {
            navigationTitle = "치킨"
            storeBoardInit(url: url("/store/list/102"))
            
        } else if sender.tag == 2 {
            navigationTitle = "피자"
             // storeBoardInit(url: url("/store/list/103"))
        } else {
            navigationTitle = "야식"
            //storeBoardInit(url: url("/store/list/104"))
        }
    }
    
    
    func storeBoardInit(url : String){
        BoardService.shareInstance.boardInit(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
    
            switch result {
            case .networkSuccess(let storeData):
                self.stores = storeData
                if let MenuDetailTVC = self.storyboard?.instantiateViewController(withIdentifier:"MenuDetailTVC") as? MenuDetailTVC {
                    MenuDetailTVC.stores = self.stores
                    MenuDetailTVC.navigationItem.title = self.navigationTitle
                    self.navigationController?.pushViewController(MenuDetailTVC, animated: true)
                }
                break

            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
         
        })
        
    }
    


}
