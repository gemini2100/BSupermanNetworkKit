//
//  ViewController.swift
//  BSupermanNetworkKit
//
//  Created by gemini2100 on 03/22/2018.
//  Copyright (c) 2018 gemini2100. All rights reserved.
//

import UIKit
import RxSwift
import BSupermanNetworkKit

class ViewController: UIViewController {

    //let manager = BSupermanNetworkManager<BSupermanNetworkAPI>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let endpoint = BSupermanNetworkAPI.userLogin(name: "11223344553", password: "123456")

        
        let resultObservable: Observable<(String?,LoginEntity?)> = networkKitRequest(endPoint: endpoint)
        
            _ = resultObservable.subscribe(onNext: { ( result:(responseError:String?,data:LoginEntity?)) in
                print("get result: \(result)")

            },
                       onError: { (error:Error) in print(" Get error:\(error)")},
                       onCompleted: {print("onCompleted!!")},
                       onDisposed: {print("onDisposed!!")})
        
        
        
//        BSupermanNetworkManager<BSupermanNetworkAPI>.requestAPI(endPoint: endpoint , isUserSampleFile: false).subscribe { (result:Event<ResponseResult<LoginEntity>>) in
//            print("\(result)")
//        }
//            .subscribe(onNext: { ( result:ResponseResult<LoginEntity>) in
//                print("get result: \(result)")
//
////                switch result {
////
////                case let .succeed(data):
////
////                    //self.storeAppConfigure(Cfg: data.cfg!)
////
////                    //self.getAppConfigure()
////                    print(data)
////
////                }
//
//
//
//            })//,
//                       onError: { print(" Get error:\($0)")},
//                       onCompleted: {print("onCompleted!!")},
//                       onDisposed: {print("onDisposed!!")})
        
        //
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

