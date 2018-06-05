//
//  StoreDetailVC.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit


class StoreDetailVC: UIViewController, APIService {
    
    var like : UIBarButtonItem = UIBarButtonItem()
    var likeEmpty : UIBarButtonItem = UIBarButtonItem()
    
    @IBOutlet weak var containerView    : UIView!
    var selectedStore:Store!
    //원래 selectedStore.isMarked 받아와야함
    var isMarked : Bool = true {
        didSet {
          navigationItem.rightBarButtonItems = self.isMarked ? [like] : [likeEmpty]
        }
    }
    
    override func viewDidLoad() {
   
        super.viewDidLoad()

        self.navigationItem.title = selectedStore.storeName
        
        isMarked = self.selectedStore.bookmarkCheck
        
        like = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "heart"), target: self, action: #selector(deleteBookmark))
        likeEmpty = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "heartEmpty"), target: self, action: #selector(checkBookmark))

        navigationItem.rightBarButtonItems = self.isMarked ? [like] : [likeEmpty]
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        setupMenuBar()
        setupView()
        
    }
    
    @objc func sample(){
        self.isMarked = (self.isMarked) ? false : true
    }
    
    @objc func deleteBookmark(){
        
        let params : [String : Any] = [
            "store_idx" : selectedStore.storeIdx,
            "user_id" : UserDefaults.standard.string(forKey: "userId")!
        ]
        
        BookmarkService.shareInstance.deleteBookmark(URL: url("/bookmark/like"), params: params) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                self.isMarked = false
            case .serverErr :
                self.simpleAlert(title: "오류", message: "서버에러")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
            default :
                break
            }
        }
        
    }
    
    @objc func checkBookmark(){
        
        let params : [String : Any] = [
            "store_idx" : selectedStore.storeIdx,
            "user_id" : UserDefaults.standard.string(forKey: "userId")!
        ]
        
        BookmarkService.shareInstance.checkBookmark(URL: url("/bookmark/like"), params: params) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                self.isMarked = true
            case .serverErr :
                self.simpleAlert(title: "오류", message: "서버에러")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
            default :
                break
            }
            
        }
        
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





