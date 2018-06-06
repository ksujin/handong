//
//  Review.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 6..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation


struct ReviewData: Codable {
    let status : Bool
    let message: String
    let result : [Review]
}

struct Review: Codable {
    let reviewContent : String
    let reviewPhoto : String?
    let reviewTime : String
    let userIdx : Int
    let userId : String
    
    enum CodingKeys: String, CodingKey {
        case reviewContent = "review_content"
        case reviewPhoto = "review_photo"
        case reviewTime = "review_time"
        case userIdx = "user_idx"
        case userId = "user_id"
    }
    
    
}
