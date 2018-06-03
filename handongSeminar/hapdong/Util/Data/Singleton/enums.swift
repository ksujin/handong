//
//  enums.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
    case failure(Error)
}

enum NetworkResult<T> {
    case networkSuccess(T)
    case nullValue
    case duplicated
    case serverErr
    case networkFail
    case wrongInput
}

