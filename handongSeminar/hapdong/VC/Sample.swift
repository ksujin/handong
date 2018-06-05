//
//  Sample.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 4..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation

var menuLists = [[String : Any]]()
var menu1 : [String : Any] = [
    "menu_name" : "rice",
    "menu_price" : "1000"
    ]

func a(){
    menuLists.append(menu1)
}

let parmas : [String : Any] = [
    "user_id" : "1",
    "store_name" : "store",
    "store_category" : "101",
    "store_content" : "test",
    "menu_list" : menuLists
]
