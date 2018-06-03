//
//  RegisterReviewService.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation

struct RegisterReviewService: PostablewithPhoto {
    

    typealias NetworkData = DefaultVO
    static let shareInstance = RegisterReviewService()
    func registerReview(url : String, params : [String : Any], image : [String : Data]?, completion : @escaping (NetworkResult<Any>) -> Void){
       
        savePhotoContent(url, params: params, imageData: image) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "success" :
                    completion(.networkSuccess(""))
                case "400 error" :
                    completion(.nullValue)
                case "Interanal Server Error!" :
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
