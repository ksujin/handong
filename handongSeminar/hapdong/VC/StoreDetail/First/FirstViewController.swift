//
//  FirstViewController.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    @IBOutlet weak var firstTableView: UITableView!
    var menues : [MenuVO] = []
    var selectedStore:Store!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedStore.storeIdx)
       // firstTableView.tableFooterView = UIView(frame: .zero)
        firstTableView.delegate = self
        firstTableView.dataSource = self
        // Do any additional setup after loading the view.
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
