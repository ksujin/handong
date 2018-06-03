//
//  ThirdViewController.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 22..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var thirdTableView: UITableView!
    
    @IBAction func registerReviewBtn(_ sender: Any) {
        let parentVC = self.parent as! StoreDetailVC
        let selectedStoreIdx = parentVC.selectedStore.storeIdx
        let registerReviewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterReviewVC") as! RegisterReviewVC
        registerReviewVC.storeIdx = selectedStoreIdx
        self.navigationController?.pushViewController(registerReviewVC, animated: true)
    }
    var reviews : [ReviewVO] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //thirdTableView.tableFooterView = UIView(frame: .zero)
        thirdTableView.delegate = self
        thirdTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
}

extension ThirdViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reviews.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ThirdTableViewCell.reuseIdentifier) as! ThirdTableViewCell
        
        cell.configure(review: reviews[indexPath.row])
        
        return cell
        
    }

}
