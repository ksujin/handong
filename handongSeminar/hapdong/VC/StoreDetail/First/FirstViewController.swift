//
//  FirstViewController.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, APIService {

    
    @IBOutlet weak var firstTableView: UITableView!
    var menues : [Menu] = []
    var selectedStore:Store!
    
    
    override func viewWillAppear(_ animated: Bool) {
          menuBoardInit(url: url("/store/menu/\(selectedStore.storeIdx)"))
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
   
        firstTableView.tableFooterView = UIView(frame: .zero)
        firstTableView.delegate = self
        firstTableView.dataSource = self
        
        menuBoardInit(url: url("/store/menu/\(selectedStore.storeIdx)"))
    }
    
    func menuBoardInit(url : String){
        MenuService.shareInstance.menuInit(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let menudata):
                self.menues = menudata as! [Menu]
                self.firstTableView.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
             
            default :
                break
            }
            
            }, store: selectedStore.storeIdx )
        
    }
    
}


extension FirstViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menues.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.reuseIdentifier) as! FirstTableViewCell
        
        cell.configure(menu: menues[indexPath.row])
        
        
        return cell
        
    }
    
    
}
