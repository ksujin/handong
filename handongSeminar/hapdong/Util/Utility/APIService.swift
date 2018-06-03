//
//  APIService.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 1..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation

protocol APIService {}

extension APIService {
    func url(_ path: String) -> String {
        return "http://13.125.52.80:3000" + path
    }
    
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
}

