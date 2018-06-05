//
//  StoreVO.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 21..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation

struct Store: Codable {
    let storeIdx: Int
    let storeName: String
    let storeCategory: String
    let storePhoto : String?
    let storeContent: String?
    let userIdx : Int
    let bookmarkCheck : Bool
    
    enum CodingKeys: String, CodingKey {
        case storeIdx = "store_idx"
        case storeName = "store_name"
        case storeCategory = "store_category"
        case storePhoto = "store_photo"
        case storeContent = "store_content"
        case userIdx = "user_idx"
        case bookmarkCheck = "bookmarkCheck"
    }
}

