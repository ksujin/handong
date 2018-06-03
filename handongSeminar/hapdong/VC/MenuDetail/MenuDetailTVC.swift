//
//  MenuDetailTVC.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class MenuDetailTVC: UITableViewController {
    
    var stores : [Store] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        addRightBarButton(image: #imageLiteral(resourceName: "add"), selector: #selector(self.goToAddStoreView))

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
    

}

extension MenuDetailTVC {
    
    @objc func goToAddStoreView(){
        if let RegisterStoreVC = UIStoryboard(name: "Sub", bundle : nil).instantiateViewController(withIdentifier:"RegisterStoreVC") as? RegisterStoreVC {
            self.navigationController?.pushViewController(RegisterStoreVC, animated: true)
        }
    }
    
}
