//
//  SignInVC.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 1..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class SignInVC: UIViewController, APIService {

    @IBOutlet weak var idTxt: UITextField!
    
    @IBOutlet weak var pwdTxt: UITextField!
    let userId : String = "user_id"
    let userPwd : String = "user_pw"
    
    let userDefault = UserDefaults.standard
    
    //@IBAction func goFirst(segue: UIStoryboardSegue){}
    
    @IBAction func loginBtnAction(_ sender: Any) {
        if (idTxt.text?.isEmpty)! || (pwdTxt.text?.isEmpty)! {
            simpleAlert(title: "로그인 실패", message: "모든 항목을 입력해 주세요")
            return
        }
        
        let params: [String:Any] = [
            userId : gsno(idTxt.text),
            userPwd : gsno(pwdTxt.text)
        ]
  
        LoginService.shareInstance.login(url: url("/signin"), params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let userIdx):
                self.userDefault.set((userIdx as? Int), forKey: "userIdx")
                self.userDefault.set(self.idTxt.text, forKey: "userId")
                
                let boardVCNavi = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navi")
                self.present(boardVCNavi, animated: true, completion: nil)
                break
            case .wrongInput :
                self.simpleAlert(title: "오류", message: "아이디와 비밀번호를 확인해주세요")
                break
            case .nullValue :
                self.simpleAlert(title: "오류", message: "빈 값이 들어갑니다")
            case .serverErr :
                self.simpleAlert(title: "오류", message: "서버 에러")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
            default :
                break
            }

        })
        

        
    }
    
    
    @IBAction func joinBtnAction(_ sender: Any) {
        if let joinVC = storyboard?.instantiateViewController(withIdentifier: "JoinVC") as? JoinVC {
            
            self.navigationController?.pushViewController(joinVC, animated: true)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
