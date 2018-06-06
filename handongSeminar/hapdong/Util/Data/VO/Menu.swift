//
//  Menu.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 6..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation

struct MenuData: Codable {
    let status : Bool
    let message: String
    let result : [Menu]
}

struct Menu: Codable {
    let menuName: String
    let menuPrice : String
    
    enum CodingKeys: String, CodingKey {
        case menuName = "menu_name"
        case menuPrice = "menu_price"
    }
}
