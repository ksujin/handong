//
//  Extensions.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    
    
    func simpleAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func simpleAlertwithHandler(title: String, message: String, okHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func addRightBarButton(image : UIImage, selector : Selector){
        let btn1 = UIButton(type: .custom)
        btn1.setImage(image, for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: selector, for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        //navigation bar 에서 버튼 크기 조정하기 위함
        let currWidth = item1.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = item1.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
    }
    
    func networkFailed(){
        
        simpleAlert(title: "실패", message: "인터넷 연결상태를 확인해주세요");
    }
    
    
}


extension NSObject {
    static var reuseIdentifier:String {
        return String(describing:self)
    }
}

extension UIView {
    func roundedBorder() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
        func addConstraintsWithFormat(_ format: String, views: UIView...) {
            var viewsDictionary = [String: UIView]()
            for (index, view) in views.enumerated() {
                let key = "v\(index)"
                view.translatesAutoresizingMaskIntoConstraints = false
                viewsDictionary[key] = view
            }
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        }
    
}


extension UITableViewCell {
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
}


protocol Gallery : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var homeController : UIViewController? {get set}
    func openGalleryCamera()
}


extension Gallery   {
    
    
    
    func openGalleryCamera(){
        let selectAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let libraryAction = UIAlertAction(title: "앨범", style: .default) { _ in if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.homeController?.present(imagePicker, animated: true, completion: nil)
            }
            
        }
        let cameraAction = UIAlertAction(title: "카메라", style: .default) {
            _ in  if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.allowsEditing = true
                self.homeController?.present(imagePicker, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        selectAlert.addAction(libraryAction)
        selectAlert.addAction(cameraAction)
        selectAlert.addAction(cancelAction)
        self.homeController?.present(selectAlert, animated: true, completion: nil)
    }
}

extension UIBarButtonItem {
    class func itemWith(colorfulImage: UIImage?, target: AnyObject, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}

extension Collection where Iterator.Element == [String:AnyObject] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:Any]],
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
    
    func toJSONData() -> Data {
        if let arr = self as? [[String:Any]],
            let dat = try? JSONSerialization.data(withJSONObject: arr)
             {
            return dat
        }
        return Data()
    }
}

/* let arrayOfDictionaries = [
 { "abc": 123, "def": "ggg", "xyz": true },
 { "abc": 456, "def": "hhh", "xyz": false },
 { "abc": 789, "def": "jjj", "xyz": true }
 ]
 
 print(arrayOfDictionaries.toJSONString())
 
 
 [
 {
 "abc" : 123,
 "def" : "ggg",
 "xyz" : true
 },
 {
 "abc" : 456,
 "def" : "hhh",
 "xyz" : false
 }
 ]
 */


