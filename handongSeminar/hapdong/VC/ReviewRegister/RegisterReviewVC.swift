//
//  RegisterReviewVC.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class RegisterReviewVC: UIViewController, Gallery, APIService {
    var homeController: UIViewController?

    @IBOutlet weak var reviewExplainTextView: UITextView!
    @IBOutlet weak var storeImageView: UIImageView!
    var storeIdx : Int = 0 
    var imageData : Data? = nil
    var images : [String : Data]?
    @IBAction func addBtn(_ sender: UIButton) {
        
        if(reviewExplainTextView.text.isEmpty){
            simpleAlert(title: "오류", message: "텍스트 채워주세요")
            return
        }

        let params : [String : Any] = [
            "store_idx" : storeIdx,
            "user_id" : UserDefaults.standard.string(forKey: "userId")!,
            "review_content" : reviewExplainTextView.text
        ]
        
        if let image = imageData {
            images = [
            "review_photo" : image
            ]
        }
        
        
        RegisterReviewService.shareInstance.registerReview(url: url("/store/review"), params: params, image: images) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                self.simpleAlertwithHandler(title: "성공", message: "등록성공", okHandler: { (_) in
                    self.navigationController?.popViewController(animated: false)
                })
            case .nullValue :
                self.simpleAlert(title: "오류", message: "텍스트 비어있음")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
            default :
                break
            }
            
        }
    }
    
  
    
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        
        openGalleryCamera()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeController = self
        storeImageView.isUserInteractionEnabled = true
        reviewExplainTextView.delegate = self
        self.tabBarController?.tabBar.isHidden = true

    }
    
    
}

//텍스트 뷰 바뀔 때 마다 동적으로 높이 조절
extension RegisterReviewVC : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        reviewExplainTextView.translatesAutoresizingMaskIntoConstraints = true
       
        textView.isScrollEnabled = false
        let fixedWidth = textView.frame.size.width
        let originHeight = textView.frame.size.height
        
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        var originFrame = textView.frame
        originFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: originHeight)
        if (newSize.height < originHeight ){
            textView.frame = originFrame
        } else {
            textView.frame = newFrame
        }
        
        
    
    }

    
}


//이미지 피커
extension RegisterReviewVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate
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

