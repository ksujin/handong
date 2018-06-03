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
        
        addRightBarButton(image: #imageLiteral(resourceName: "add"), selector: #selector(self.goToAddStoreView))
        
        switch selectedCategory {
        case 101 :
             self.navigationItem.title = "한식"
            storeBoardInit(url: url("/store/list/101"))
        case 102 :
            self.navigationItem.title = "치킨"
            storeBoardInit(url: url("/store/list/102"))
        case 103 :
            self.navigationItem.title = "피자"
            storeBoardInit(url: url("/store/list/103"))
        case 104 :
            self.navigationItem.title = "야식"
            storeBoardInit(url: url("/store/list/104"))
        default :
            print("no category")
        }

    }


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

extension MenuDetailTVC {
    
    @objc func goToAddStoreView(){
        if let RegisterStoreVC = UIStoryboard(name: "Sub", bundle : nil).instantiateViewController(withIdentifier:"RegisterStoreVC") as? RegisterStoreVC {
            self.navigationController?.pushViewController(RegisterStoreVC, animated: true)
        }
    }
    
}
