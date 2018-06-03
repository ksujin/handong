//
//  HttpResponseCode.swift
//  hapdong
//
//  Created by 강수진 on 2018. 6. 1..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation

enum HttpResponseCode: Int{
    case GET_SUCCESS = 200
    case POST_SUCCESS = 201
    case WRONG_REQUEST = 400
    case SERVER_ERROR = 500
}

