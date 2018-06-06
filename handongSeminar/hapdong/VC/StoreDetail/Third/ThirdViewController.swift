//
//  ThirdViewController.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 22..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, APIService {

    @IBOutlet weak var thirdTableView: UITableView!
    var selectedStore:Store!
    @IBAction func registerReviewBtn(_ sender: Any) {
        let parentVC = self.parent as! StoreDetailVC
        let selectedStoreIdx = parentVC.selectedStore.storeIdx
        let registerReviewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterReviewVC") as! RegisterReviewVC
        registerReviewVC.storeIdx = selectedStoreIdx
        self.navigationController?.pushViewController(registerReviewVC, animated: true)
    }
    var reviews : [Review] = []
    
    override func viewWillAppear(_ animated: Bool) {
         reviewBoardInit(url: url("/store/review/\(selectedStore.storeIdx)"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        thirdTableView.tableFooterView = UIView(frame: .zero)
        thirdTableView.delegate = self
        thirdTableView.dataSource = self
        
        reviewBoardInit(url: url("/store/review/\(selectedStore.storeIdx)"))
    }
    func reviewBoardInit(url : String){
       
        ReviewGetService.shareInstance.reviewInit(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let ReviewGetData):
               
                print(ReviewGetData)
                self.reviews = ReviewGetData as! [Review]
                self.thirdTableView.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
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
