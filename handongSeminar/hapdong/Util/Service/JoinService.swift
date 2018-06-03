//
//  JoinService.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct JoinService: PostableService {
    typealias NetworkData = DefaultVO
    static let shareInstance = JoinService()
    func join(url : String, params : [String : Any], completion : @escaping (NetworkResult<Any>) -> Void){
        post(url, params: params) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "Successfully Sign up" :
                    completion(.networkSuccess(""))
                case "Null Value" :
                    completion(.nullValue)
                case "Already Exists" :
                    completion(.duplicated)
                case "Internal Server Error!" :
                    completion(.serverErr)
                default :
                    break
                }
                
                break
            case .error(let errMsg) :
                print(errMsg)
                break
            case .failure(_) :
                completion(.networkFail)
            }
        }
        
    }
    
}
