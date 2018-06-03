//
//  JoinVC.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class JoinVC: UIViewController , APIService {

   
    
    @IBOutlet weak var idTxt: UITextField!
    @IBOutlet weak var pwdTxt: UITextField!
    @IBOutlet weak var joinBtn: UIButton!
    

    let userId : String = "user_id"
    let userPwd : String = "user_pw"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
     
        joinBtn.addTarget(self, action: #selector(joinBtnClick(_:)), for: UIControlEvents.touchUpInside)
        
        pwdTxt.addTarget(self, action: #selector(isValid), for: .editingChanged)
        idTxt.addTarget(self, action: #selector(isValid), for: .editingChanged)
       
        joinBtn.isEnabled = false
        joinBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
    }
    
    @objc func joinBtnClick(_ sender:UIButton){
       
        let params: [String:Any] = [
            userId : gsno(idTxt.text),
            userPwd : gsno(pwdTxt.text)
        ]
        
        JoinService.shareInstance.join(url: url("/signup"), params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                self.simpleAlertwithHandler(title: "성공", message: "회원가입 성공!", okHandler: self.joinOkHandler(_:))
                break
            case .duplicated :
                self.simpleAlert(title: "오류", message: "존재하는 아이디입니다")
                break
            case .nullValue :
                self.simpleAlert(title: "오류", message: "빈 값이 들어갑니다")
            case .serverErr :
                self.simpleAlert(title: "오류", message: "서버 에러")
            case .networkFail :
                self.networkFailed()
            default :
                break
            }
            
        })
    }
    
    func joinOkHandler(_ sender:UIAlertAction) -> Void {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    

    @objc func isValid(){
        if (!(idTxt.text?.isEmpty)! && !(pwdTxt.text?.isEmpty)!){
            joinBtn.isEnabled = true
            joinBtn.backgroundColor = #colorLiteral(red: 0.5769622326, green: 0.7527424693, blue: 0.9601681828, alpha: 1)
            
        } else {
            joinBtn.isEnabled = false
            joinBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }

}
