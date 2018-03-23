//
//  BSupermanNetworkAPI+TargetType.swift
//  rushsuperman
//
//  Created by 陈秋松 on 2018/1/22.
//  Copyright © 2018年 Nicky. All rights reserved.
//

import Foundation

import Moya

extension BSupermanNetworkAPI: TargetType
{
    var baseURL: URL
    {
        return URL(string: "https://demo.51superman.com:4430/")!
    }
    
    var method: Moya.Method
    {
        return .post
    }
    
    var headers: [String : String]?
    {
        return nil

    }
    
    var task: Task
    {
        return .requestParameters(parameters:  getParameters(), encoding: URLEncoding.default)
    }
    
    //这个就是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    public var sampleData: Data
    {
        let path = Bundle.main.path(forResource: "responseJsonSample", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }
    
    var path: String
    {
        return getPath()
    }
    
    var parameters: [String: Any]?
    {
        return getParameters()
    }
}
