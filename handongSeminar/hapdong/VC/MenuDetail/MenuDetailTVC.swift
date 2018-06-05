//
//  MenuDetailTVC.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class MenuDetailTVC: UITableViewController, APIService {
    
    var selectedCategory : Int = 0 
    var stores : [Store] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: .zero)
        print("aaa")
        addRightBarButton(image: #imageLiteral(resourceName: "add"), selector: #selector(self.goToAddStoreView))
        
        switch selectedCategory {
        case 101 :
             self.navigationItem.title = "한식"
        case 102 :
            self.navigationItem.title = "치킨"
        case 103 :
            self.navigationItem.title = "피자"
        case 104 :
            self.navigationItem.title = "야식"
        default :
            print("no category")
        }
        
        self.storeBoardInit(url : url("/store/list"))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.storeBoardInit(url:  url("/store/list"))
        
    }
    
    func storeBoardInit(url : String){
        
        let params : [String : Any] = [
            "user_id" : UserDefaults.standard.string(forKey: "userId")!,
            "category" : String(selectedCategory)
        ]
        
        BoardService.shareInstance.boardInit(url: url, params : params, completion: { [weak self] (result) in
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

//tableView deleagte, datasource
extension MenuDetailTVC {
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

extension MenuDetailTVC {
    
    @objc func goToAddStoreView(){
        if let RegisterStoreVC = UIStoryboard(name: "Sub", bundle : nil).instantiateViewController(withIdentifier:"RegisterStoreVC") as? RegisterStoreVC {
            
            self.navigationController?.pushViewController(RegisterStoreVC, animated: true)
        }
    }
    
}
