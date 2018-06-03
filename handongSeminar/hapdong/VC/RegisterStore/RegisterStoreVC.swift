//
//  RegisterStoreVC.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class RegisterStoreVC: UIViewController {
    let pickerView = UIPickerView()
    let typeList = ["한식", "피자", "치킨", "야식"]

    @IBOutlet weak var storeTypeTextField: UITextField!
    @IBOutlet weak var storeExplainTextView: UITextView!
    @IBOutlet weak var storeImageView: UIImageView!
    
    var imageData : Data? = nil
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        let selectAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let libraryAction = UIAlertAction(title: "앨범", style: .default) { _ in if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            }
            
        }
        let cameraAction = UIAlertAction(title: "카메라", style: .default) {
            _ in  if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        selectAlert.addAction(libraryAction)
        selectAlert.addAction(cameraAction)
        selectAlert.addAction(cancelAction)
        self.present(selectAlert, animated: true, completion: nil)
    }
    @IBAction func addContentBtn(_ sender: UIButton) {
    
    }
    
    @IBAction func registerBtn(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initPickerView()
    
        setKeyboardSetting()
      
 
        storeExplainTextView.delegate = self
        self.tabBarController?.tabBar.isHidden = true
    }
    

}

//이미지 피커 텍스트 필드에 추가
extension RegisterStoreVC :UIPickerViewDelegate, UIPickerViewDataSource{
   
    func initPickerView() {
        
        let barFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        let bar = UIToolbar(frame: barFrame)
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectType))
        
        let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        bar.setItems([btnSpace, btnDone], animated: true)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        storeTypeTextField.inputView = pickerView
        storeTypeTextField.inputAccessoryView = bar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeList[row]
    }
    
    @objc func selectType() {
        let row = pickerView.selectedRow(inComponent: 0)
        storeTypeTextField.text = typeList[row]
        view.endEditing(true)
    }
}

 //텍스트 뷰 바뀔 때 마다 동적으로 높이 조절
extension RegisterStoreVC : UITextViewDelegate {
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        adjustUITextViewHeight(arg: textView)
    }
    
}


//이미지 피커
extension RegisterStoreVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            storeImageView.image = editedImage
            imageData = UIImageJPEGRepresentation(editedImage, 0.1)
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            storeImageView.image = originalImage
            imageData = UIImageJPEGRepresentation(originalImage, 0.1)
        }
        self.dismiss(animated: true) {
     
        }
    
    }
    
  
}


//keyboard
extension RegisterStoreVC {
    
    //////// 외우지 않아도 되는 부분입니다. 표시된 부분만 고쳐서 사용하세요. ////////
    // 코드 설명 : 키보드가 나올 때 키보드의 높이를 계산해서 댓글 뷰가 키보드 위에 뜰 수 있도록 합니다.
    //          view.frame을 조정하면 키보드가 나오고 들어갈 때 뷰가 움직이게 되겠지요?
    //          notification : 옵저버라고 생각하시면 됩니다. 시점을 캐치하여 #selector()의 액션이 일어나도록 합니다.
    //                          이 코드에서는 키보드가 나올 때, 들어갈 때 의 시점을 캐치하여 뷰의 frame을 조정합니다.
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //////// 키보드의 사이즈만큼 commentSendView의 y축을 위로 이동시킴 ////////
            //here
            self.view.frame.origin.y -= keyboardSize.height
            ////////
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //////// 키보드의 사이즈만큼 commentSendView의 y축을 아래로 이동시킴 ////////
            //here
            self.view.frame.origin.y += keyboardSize.height
            ////////
            self.view.layoutIfNeeded()
        }
    }
    
    //화면 바깥 터치했을때 키보드 없어지는 코드
    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
    ////////
}
