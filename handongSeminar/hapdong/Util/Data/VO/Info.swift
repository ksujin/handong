//
//  Info.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 6..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation

struct InfoData: Codable {
    let status : Bool
    let message: String
    let result : [Info]
}

struct Info: Codable {
    let storePhoto: String
    let storeContent : String
    let reviewCount : Int
    
    enum CodingKeys: String, CodingKey {
        case storePhoto = "store_photo"
        case storeContent = "store_content"
        case reviewCount = "review_count"
    }
}
