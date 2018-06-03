import UIKit

class SegementedVC: UIViewController {
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Outlets
    //----------------------------------------------------------------
    
    @IBOutlet weak var segmentControl   : UISegmentedControl!
    @IBOutlet weak var containerView    : UIView!
    
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Variables
    //----------------------------------------------------------------
    
    private lazy var firstViewController: FirstViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var secondViewController: SecondViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Abstract Method
    //----------------------------------------------------------------
    
    static func viewController() -> SegementedVC {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SegementedView") as! SegementedVC
    }
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Memory Management Methods
    //----------------------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Action Methods
    //----------------------------------------------------------------
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        updateView()
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
    
    private func updateView() {
        if segmentControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: secondViewController)
            add(asChildViewController: firstViewController)
        } else {
            remove(asChildViewController: firstViewController)
            add(asChildViewController: secondViewController)
        }
    }
    
    //----------------------------------------------------------------
    
    func setupView() {
        updateView()
    }
    
    
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- View Life Cycle Methods
    //----------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    //----------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //----------------------------------------------------------------
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
