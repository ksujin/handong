//
//  ReviewVO.swift
//  hapdong
//
//  Created by 강수진 on 2018. 5. 22..
//  Copyright © 2018년 강수진. All rights reserved.
//

import Foundation
class ReviewVO {
    var reviewWriter : String
    var image : String
    var reviewContent : String
    var date : String
    
    init(reviewWriter : String, image : String, reviewContent : String, date : String){
        self.reviewWriter = reviewWriter
        self.image = image
        self.reviewContent = reviewContent
        self.date = date
    }
}
