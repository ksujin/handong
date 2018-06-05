//
//  BookmarkService.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 4..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation
struct BookmarkService : PostableService {
    
    typealias NetworkData = DefaultVO
    static let shareInstance = BookmarkService()
    func checkBookmark(URL : String, params : [String : Any], completion : @escaping (NetworkResult<Any>) -> Void) {
        post(URL, params: params) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "success" :
                    completion(.networkSuccess(""))
                case "500/400 error" :
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
    
    func deleteBookmark(URL : String, params : [String : Any], completion : @escaping (NetworkResult<Any>) -> Void){
        delete(URL, params: params) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "success" :
                    completion(.networkSuccess(""))
                case "500/400 error" :
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
