//
//  BSupermanNetworkAPI.swift
//  rushsuperman
//
//  Created by 陈秋松 on 2018/1/22.
//  Copyright © 2018年 Nicky. All rights reserved.
//

import Foundation

enum BSupermanNetworkAPI
{
    case userLogin(name:String,password:String)    //登陆
    case getmytasks                                 //我的任务主列表
    case taskDetails
    
    
    func getPath()->String
    {
        switch self
        {
        case .userLogin:
            return "user/login"
        case .getmytasks:
            return "map/getmytasks"
        case .taskDetails:
            return "map/getmytasks"
        }
    }
    
    func getParameters()->[String: String]
    {
        switch self
        {
        case .userLogin(let name , let password):
            return ["username" : name,"password" : password]
        case .getmytasks:
            return ["":""]
        default:
            return ["":""]
        }
    }
}
