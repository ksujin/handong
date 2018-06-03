//
//  BookmarkTVC.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 4..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class BookmarkTVC: UITableViewController, APIService {
    
    var stores : [Store] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        let userId = UserDefaults.standard.string(forKey: "userId")!
        storeBoardInit(url : url("/bookmark/list/\(userId)"))
    }
    
    
    //TODO - bookmark get 할때랑 메시지 같게 달라고 하기
    func storeBoardInit(url : String){
        BoardService.shareInstance.boardInit(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let storeData):
                self.stores = storeData
                self.tableView.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
    }
    
}

//BookmarkTVC datasource & deleagate
extension BookmarkTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stores.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuDetailCell.reuseIdentifier) as! MenuDetailCell
        
        cell.configure(store: stores[indexPath.row])
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let StoreDetailVC = UIStoryboard(name: "Main", bundle : nil).instantiateViewController(withIdentifier: "StoreDetailVC") as! StoreDetailVC
        
        StoreDetailVC.selectedStore = stores[indexPath.row]
        
        self.navigationController?.pushViewController(StoreDetailVC, animated: true)
        
    }
}
