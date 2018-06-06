//
//  File.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 6..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation
import SwiftyJSON
struct RegisterStoreService: PostablewithPhoto {
    
    
    typealias NetworkData = DefaultVO
    static let shareInstance = RegisterStoreService()
    func registerStore(url : String, params : [String : Any], dicArr : [String : [[String : Any]]], image : [String : Data]?, completion : @escaping (NetworkResult<Any>) -> Void){
        
        savePhotowithArray(url, params: params, dicArr : dicArr, imageData: image) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.message {
                case "Successfully regist store" :
                    completion(.networkSuccess(""))
                case "400 error" :
                    print("why")
                    completion(.nullValue)
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

