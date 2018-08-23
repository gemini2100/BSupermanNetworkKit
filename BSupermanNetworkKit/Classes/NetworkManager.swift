//
//  NetworkManager.swift
//  rushsuperman
//
//  Created by 陈秋松 on 2018/1/22.
//  Copyright © 2018年 Nicky. All rights reserved.
//

import Foundation

import RxSwift
import Moya

//fileprivate let provider: MoyaProvider<BSupermanNetworkAPI> = {
//    let stubClosure = { (target: BSupermanNetworkAPI) -> StubBehavior in
//        return .never//.immediate和.delay(x)返回sampleData
//    }
//    let networkLoggerPlugin = NetworkLoggerPlugin(cURL: true)
//    let plugins = [networkLoggerPlugin]
//    return MoyaProvider<BSupermanNetworkAPI>(stubClosure: stubClosure, plugins: plugins)
//}()

fileprivate let otherExceptionMessgae = "网络连接异常，请检查网络设置!"
fileprivate let jsonExceptionMessgae =  "数据结构异常，请检查网络设置!"
fileprivate let sampleDelaySeconds = 5.0

// 固定返回数据的json格式

class ResponseData<T: Codable>: Codable
{
    let error : String
    let msg : String
    var data : T?
    
    enum CodingKeys: String, CodingKey
    {
        case data = "data"
        case error = "error"
        case msg = "msg"
    }
    
    required public init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decode(String.self, forKey: .msg)
        error = try values.decode(String.self, forKey: .error)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
}


/// 请求网络数据
///
/// - Parameters:
///   - endPoint: Moya的TargetType子类,包括了URL、请求方式等信息
///   - debugMode: 是否debug模式，debug模式下直接使用工程下的responseJsonSample.json文件代替返回数据
/// - Returns: 元组(errorString,data),errorString不为空表示返回错误描述，data肯定为空。反之表示成功，errorString为nil，data有数据.
public func networkKitRequest <JsonDataEntityType: Codable,networkAPI:TargetType> (endPoint: networkAPI, debugMode:Bool = false) -> Observable<(String?,JsonDataEntityType?)>
{
    return Observable.create(
        {
            observer in
            
            let provider: MoyaProvider<networkAPI> = {
                let stubClosure = { ( _ : networkAPI) -> StubBehavior in
                    return debugMode ? StubBehavior.delayed(seconds: TimeInterval(sampleDelaySeconds)) : StubBehavior.never
                }
                return MoyaProvider<networkAPI>(stubClosure: stubClosure)
            }()
            
            let callBack = provider.request(endPoint, completion:
            {
                responseResult in
                switch responseResult
                {
                case let .success(response):
                    do
                    {
                        let jsonDecoder = JSONDecoder()
                        let responseJson = try jsonDecoder.decode(ResponseData<JsonDataEntityType>.self, from: response.data)
                        let errorCode = responseJson.error
                        let errorMessage = responseJson.msg
                        
                        if errorCode == "SUCCESS"
                        {
                            if let data:JsonDataEntityType = responseJson.data
                            {
                                observer.onNext((nil,data))
                                observer.onCompleted()
                            }
                            else //获得数据结构解析为nil
                            {
                                observer.onNext((jsonExceptionMessgae,nil))
                                observer.onCompleted()
                            }
                        }
                        else
                        {
                            //从服务器返回服务器提示的错误
                            observer.onNext((errorMessage,nil))
                            observer.onCompleted()
                        }
                    }
                    catch //解析json异常
                    {
                        observer.onNext((jsonExceptionMessgae,nil))
                        observer.onCompleted()
                    }
                case .failure(_):
                    observer.onNext((otherExceptionMessgae,nil))
                    observer.onCompleted()
                }
            })
            return Disposables.create{callBack.cancel()}
    })
}

