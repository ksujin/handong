//
//  DefaultVO.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation
struct LoginVO: Codable {
    let status : Bool
    let message: String
    let userIdx : Int?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case userIdx = "user_idx"
    }

}



