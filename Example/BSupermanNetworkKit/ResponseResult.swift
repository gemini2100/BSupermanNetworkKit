//
//  ResponseResult.swift
//  rushsuperman
//
//  Created by 陈秋松 on 2018/1/22.
//  Copyright © 2018年 Nicky. All rights reserved.
//

import Foundation

enum ResponseError:Error
{
    case fromService(String)
    case otherException(String)
}

enum ResponseResult <T: Codable>
{
    case succeed(data: T)
}
