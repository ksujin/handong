//
//  StoreData.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation

struct StoreData: Codable {
    let status : Bool
    let message: String
    let result : [Store]
}
