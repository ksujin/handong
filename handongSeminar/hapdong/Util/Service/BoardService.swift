//
//  BoardService.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct BoardService: PostableService {
    typealias NetworkData = StoreData
    static let shareInstance = BoardService()
    func boardInit(url : String, params : [String : Any], completion : @escaping (NetworkResult<[Store]>) -> Void){
      
        post(url, params : params) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "successfully load store list" :
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
