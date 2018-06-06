//
//  MenuService.swift
//  hapdong
//
//  Created by 조예은 on 2018. 6. 6..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MenuService: GettableService {
    
    typealias NetworkData = MenuData
    static let shareInstance = MenuService()
    
    func menuInit(url : String, completion : @escaping (NetworkResult<Any>) -> Void, store : Int){
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "success" :
                    completion(.networkSuccess(networkResult.result))
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

