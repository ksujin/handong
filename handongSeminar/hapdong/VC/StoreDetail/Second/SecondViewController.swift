//
//  SecondViewController.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, APIService {

   
    @IBOutlet weak var infoImageVeiw: UIImageView!
    @IBOutlet weak var infoReviewNumLabel: UILabel!
    @IBOutlet weak var infoStoreExLabel: UILabel!
    
    var selectedStore:Store!
    
    var infos : [Info] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        infoBoardInit(url: url("/store/info/\(selectedStore.storeIdx)"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        infoBoardInit(url: url("/store/info/\(selectedStore.storeIdx)"))
    }
    
    func infoBoardInit(url : String){
        
        InfoService.shareInstance.infoInit(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let infodata):
                self.infos = infodata as! [Info]
                let selectedInfo = self.infos[0]
                self.infoReviewNumLabel.text = String(selectedInfo.reviewCount)
                self.infoStoreExLabel.text = selectedInfo.storeContent
                if let url = URL(string: self.gsno(selectedInfo.storePhoto)){
                    self.infoImageVeiw.kf.setImage(with: url)
                } else {
                    self.infoImageVeiw.image = #imageLiteral(resourceName: "account")
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
