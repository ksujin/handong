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

struct BookmarkBoardService: GettableService {
    typealias NetworkData = StoreData
    static let shareInstance = BookmarkBoardService()
    func boardInit(url : String, completion : @escaping (NetworkResult<[Store]>) -> Void){
        
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




