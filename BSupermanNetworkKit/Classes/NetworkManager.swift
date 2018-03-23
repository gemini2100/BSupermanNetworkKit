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
fileprivate let jsonExceptionMessgae =  "网络数据异常，请检查网络设置!"
fileprivate let sampleDelaySeconds = 2.0

public enum ResponseError:Error
{
    case fromService(String)
    case jsonParseError(String)
    case otherException(String)
}

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

public func networkKitRequest <JsonDataEntityType: Codable,networkAPI:TargetType> (endPoint: networkAPI, debugMode:Bool = false) -> Observable<JsonDataEntityType>
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
                                observer.onNext(data)
                                observer.onCompleted()
                            }
                            else //获得数据结构解析失败
                            {
                                observer.onError(ResponseError.jsonParseError(jsonExceptionMessgae))
                            }
                        }
                        else
                        {
                            //从服务器返回服务器提示的错误
                            observer.onError(ResponseError.fromService(errorMessage))
                        }
                    }
                    catch //let jsonErr
                    {
                        //print("Json decode error: \(jsonErr.localizedDescription)")
                        observer.onError(ResponseError.jsonParseError(jsonExceptionMessgae))
                    }
                case .failure(_):                        observer.onError(ResponseError.otherException(otherExceptionMessgae))
                }
            })
            return Disposables.create{callBack.cancel()}
    })
}

