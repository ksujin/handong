//
//  StoreDetailVC.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit


class StoreDetailVC: UIViewController {
    

     @IBOutlet weak var containerView    : UIView!
    var selectedStore:Store!
    var isMarked = 0
   // let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = selectedStore.storeName
        //if 북마크 되어있으면 이미지 바뀌어야 함
        if isMarked == 0 {
            addRightBarButton(image: #imageLiteral(resourceName: "heartEmpty"), selector: #selector(self.checkBookmark))
        } else {
            addRightBarButton(image: #imageLiteral(resourceName: "heart"), selector: #selector(self.checkBookmark))
        }
     
        self.navigationController?.navigationBar.shadowImage = UIImage()
        setupMenuBar()
        setupView()
    
    }
    
 
    
    func scrollToMenuIndex(menuIndex: Int) {

        updateView(selected: menuIndex)
        
    }
    
    
   lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    
    private func setupMenuBar() {
        
        
        //메뉴바 삽입
        view.addSubview(menuBar)

        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
      
        
        
    }

    @objc func checkBookmark(){
        //네트워크
        //didSet 통해서 isMarked 가 바뀔 때 마다 heart 이미지도 바뀌도록

    }
    
 
  
  
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Variables
    //----------------------------------------------------------------
    
    private lazy var firstViewController: FirstViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
       /// viewController.menues = selectedStore.storeMenu
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var secondViewController: SecondViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var thirdViewController: ThirdViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
       // viewController.reviews = selectedStore.reviews
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Abstract Method
    //----------------------------------------------------------------
    
    static func viewController() -> StoreDetailVC {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoreDetailVC") as! StoreDetailVC
    }
    
  
    
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    //----------------------------------------------------------------
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    //----------------------------------------------------------------
    
    private func updateView(selected : Int) {
        if selected == 0 {
            remove(asChildViewController: secondViewController)
            remove(asChildViewController: thirdViewController)
            add(asChildViewController: firstViewController)
        } else if selected == 1 {
            remove(asChildViewController: firstViewController)
            remove(asChildViewController: thirdViewController)
            add(asChildViewController: secondViewController)
        } else {
            remove(asChildViewController: firstViewController)
            remove(asChildViewController: secondViewController)
            add(asChildViewController: thirdViewController)
        }
    }
    
    //----------------------------------------------------------------
    
    func setupView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        updateView(selected: 0)
    }
    
   
   
}





