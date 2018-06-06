//
//  RegisterStoreVC2.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 6..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class RegisterStoreTVC: UITableViewController,APIService, Gallery {
    
    typealias NetworkData = DefaultVO
    
    var homeController: UIViewController?
    var menuCount = 0
    var storeImageView = UIImageView()
    var bar = UIToolbar()
    let pickerView = UIPickerView()
   
    let typeList = ["한식", "피자", "치킨", "야식"]

    var imageData : Data? = nil
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    var menuLists = [[String : Any]]()
    
    var images : [String : Data]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuCount = 1
        homeController = self
        initPickerView()
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func addTextField(){
        menuCount += 1
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: menuCount-1, section: 1)], with : .bottom )
        self.tableView.endUpdates()
        

    }
    
    @IBAction func imgBtn(_ sender: UITapGestureRecognizer) {
        openGalleryCamera()
    }
    
    //TODO
//    @objc func selectImage(_ sender: UITapGestureRecognizer) {
//        openGalleryCamera()
//    }
//

    //네트워크
    @objc func registerStoreBtn() {
        for i in 0..<menuCount{
            let index = IndexPath(row: i, section: 1)
           
            if let cell2 = self.tableView.cellForRow(at: index) as? RegisterStoreCell2 {
                let name = cell2.menuNameTF.text
                let price = cell2.menuPriceTF.text
                if (name == "" || price == "") {
                    simpleAlert(title: "err", message: "input all field")
                    return
                }
                let menu = [
                    "menu_name" : name!,
                    "menu_price" : price!
                ]
                menuLists.append(menu)
            }
            
        }

        
        var storeName : String?, storeContent : String?, storeType : String!
        let indexForCell1 = IndexPath(row: 0, section: 0)
        if let cell1 = self.tableView.cellForRow(at: indexForCell1) as? RegisterStoreCell1 {
             storeName = cell1.storeNameTextField.text
             storeContent = cell1.storeExplainTextField.text
             storeType = cell1.storeTypeTextField.text
            if (storeName == "" || storeContent == "" || storeType == "") {
                simpleAlert(title: "err", message: "input all field")
                return
            }
        }
        
        var selectedStoreType : String = ""
        switch storeType {
        case "한식":
            selectedStoreType = "101"
        case "치킨":
            selectedStoreType = "102"
        case "피자":
            selectedStoreType = "103"
        case "야식":
            selectedStoreType = "104"
        default:
            simpleAlert(title: "err", message: "select one of those category")
            return
        }
        
        let params : [String : Any] = [
            "user_id" : UserDefaults.standard.string(forKey: "userId")!,
            "store_name" : storeName ?? "",
            "store_category" : selectedStoreType,
            "store_content" : storeContent ?? ""
        ]
        
        let dicArr : [String : [[String : Any]]] = [
            "menu_list" : menuLists
        ]
        
        if let image = imageData {
            images = [
                "store_photo" : image
            ]
        }
        
        RegisterStoreService.shareInstance.registerStore(url: url("/store/register"), params: params, dicArr : dicArr, image: images) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                
                self.simpleAlertwithHandler(title: "성공", message: "등록성공", okHandler: { (_) in
                    self.navigationController?.popViewController(animated: false)
                    
                })
            case .nullValue :
                self.simpleAlert(title: "오류", message: "비어있음")
            case .serverErr :
                self.simpleAlert(title: "오류", message: "서버 에러!")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
            default :
                break
            }
            
        }
        
    }

    
}

//tableview delegate & datasource

extension RegisterStoreTVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return menuCount
        } else {
            return 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RegisterStoreCell1.reuseIdentifier) as! RegisterStoreCell1
            
            cell.storeTypeTextField.inputView = pickerView
            cell.storeTypeTextField.inputAccessoryView = bar
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RegisterStoreCell2.reuseIdentifier) as! RegisterStoreCell2
            return cell
            
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RegisterStoreCell3.reuseIdentifier) as! RegisterStoreCell3
            cell.addBtn.addTarget(self, action: #selector(addTextField), for: UIControlEvents.touchUpInside)
            cell.registerBtn.addTarget(self, action: #selector(registerStoreBtn), for: UIControlEvents.touchUpInside)
            
            
            return cell
        }
    }
}

//이미지 피커 텍스트 필드에 추가
extension RegisterStoreTVC :UIPickerViewDelegate, UIPickerViewDataSource{
    
    func initPickerView() {
        
        let barFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        bar = UIToolbar(frame: barFrame)
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectType))
        
        let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        bar.setItems([btnSpace, btnDone], animated: true)

        pickerView.delegate = self
        pickerView.dataSource = self
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
        let index = IndexPath(row: 0, section: 0)
        if let cell = self.tableView.cellForRow(at: index) as? RegisterStoreCell1 {
            cell.storeTypeTextField.text = typeList[row]
        }
        view.endEditing(true)
    }
}

//텍스트 뷰 바뀔 때 마다 동적으로 높이 조절
extension RegisterStoreTVC : UITextViewDelegate {
    
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
extension RegisterStoreTVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let indexForCell1 = IndexPath(row: 0, section: 0)
        guard let cell1 = self.tableView.cellForRow(at: indexForCell1) as? RegisterStoreCell1 else { return }
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            cell1.storeImageView.image = editedImage
            imageData = UIImageJPEGRepresentation(editedImage, 0.1)
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
             cell1.storeImageView.image = originalImage
            imageData = UIImageJPEGRepresentation(originalImage, 0.1)
        }
        self.dismiss(animated: true) {
            
        }
        
    }
    
    
}
