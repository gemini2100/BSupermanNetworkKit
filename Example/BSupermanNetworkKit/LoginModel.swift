//
//  LoginModel.swift
//  rushsuperman
//
//  Created by 陈秋松 on 2018/1/22.
//  Copyright © 2018年 Nicky. All rights reserved.
//

import Foundation

struct LoginEntity : Codable
{
    let uuid : String?
    let sessionKey : String?
    let cfg : Cfg?
    
    enum CodingKeys: String, CodingKey {
        
        case uuid = "uuid"
        case sessionKey = "sessionKey"
        case cfg = "cfg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        sessionKey = try values.decodeIfPresent(String.self, forKey: .sessionKey)
        cfg = try values.decodeIfPresent(Cfg.self, forKey: .cfg)
    }
    
    struct Cfg : Codable
    {
        let versionCode : String?
        let splashDelaySeconds : String?
        let taskAreaMin : String?
        let taskAreaDefault : String?
        let taskAreaMax : String?
        let publishTaskMoneyMax : String?
        let findTaskAreaDefault : String?
        let emergencyPrice : String?
        let taskLabels : [String]?
        let redLabeCash : String?
        let redLabeSuperMoney : String?
        let refreshMSGCash : String?
        let refreshMSGSuperMoney : String?
        let depositFee : String?
        let depositTime : String?
        let depositSingleMax : String?
        let depositDailyTimes : String?
        let depositFeeMax : String?
        let squarePublishCost : String?
        let squareRangeCostSm : String?
        let squareRangeCostRMB : String?
        let reportCost : String?
        let finishAwardPercent : String?
        let finishAwardMax : String?
        let finishAwardMaxDaily : String?
        let signAwardFirst : String?
        let signAwardMax : String?
        let registerAward : String?
        let authAward : String?
        let taskValidTime : String?
        let taskCompleteTime : String?
        
        enum CodingKeys: String, CodingKey {
            
            case versionCode = "versionCode"
            case splashDelaySeconds = "splashDelaySeconds"
            case taskAreaMin = "taskAreaMin"
            case taskAreaDefault = "taskAreaDefault"
            case taskAreaMax = "taskAreaMax"
            case publishTaskMoneyMax = "publishTaskMoneyMax"
            case findTaskAreaDefault = "findTaskAreaDefault"
            case emergencyPrice = "emergencyPrice"
            case taskLabels = "taskLabels"
            case redLabeCash = "redLabeCash"
            case redLabeSuperMoney = "redLabeSuperMoney"
            case refreshMSGCash = "refreshMSGCash"
            case refreshMSGSuperMoney = "refreshMSGSuperMoney"
            case depositFee = "depositFee"
            case depositTime = "depositTime"
            case depositSingleMax = "depositSingleMax"
            case depositDailyTimes = "depositDailyTimes"
            case depositFeeMax = "depositFeeMax"
            case squarePublishCost = "squarePublishCost"
            case squareRangeCostSm = "squareRangeCostSm"
            case squareRangeCostRMB = "squareRangeCostRMB"
            case reportCost = "reportCost"
            case finishAwardPercent = "finishAwardPercent"
            case finishAwardMax = "finishAwardMax"
            case finishAwardMaxDaily = "finishAwardMaxDaily"
            case signAwardFirst = "signAwardFirst"
            case signAwardMax = "signAwardMax"
            case registerAward = "registerAward"
            case authAward = "authAward"
            case taskValidTime = "taskValidTime"
            case taskCompleteTime = "taskCompleteTime"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            versionCode = try values.decodeIfPresent(String.self, forKey: .versionCode)
            splashDelaySeconds = try values.decodeIfPresent(String.self, forKey: .splashDelaySeconds)
            taskAreaMin = try values.decodeIfPresent(String.self, forKey: .taskAreaMin)
            taskAreaDefault = try values.decodeIfPresent(String.self, forKey: .taskAreaDefault)
            taskAreaMax = try values.decodeIfPresent(String.self, forKey: .taskAreaMax)
            publishTaskMoneyMax = try values.decodeIfPresent(String.self, forKey: .publishTaskMoneyMax)
            findTaskAreaDefault = try values.decodeIfPresent(String.self, forKey: .findTaskAreaDefault)
            emergencyPrice = try values.decodeIfPresent(String.self, forKey: .emergencyPrice)
            taskLabels = try values.decodeIfPresent([String].self, forKey: .taskLabels)
            redLabeCash = try values.decodeIfPresent(String.self, forKey: .redLabeCash)
            redLabeSuperMoney = try values.decodeIfPresent(String.self, forKey: .redLabeSuperMoney)
            refreshMSGCash = try values.decodeIfPresent(String.self, forKey: .refreshMSGCash)
            refreshMSGSuperMoney = try values.decodeIfPresent(String.self, forKey: .refreshMSGSuperMoney)
            depositFee = try values.decodeIfPresent(String.self, forKey: .depositFee)
            depositTime = try values.decodeIfPresent(String.self, forKey: .depositTime)
            depositSingleMax = try values.decodeIfPresent(String.self, forKey: .depositSingleMax)
            depositDailyTimes = try values.decodeIfPresent(String.self, forKey: .depositDailyTimes)
            depositFeeMax = try values.decodeIfPresent(String.self, forKey: .depositFeeMax)
            squarePublishCost = try values.decodeIfPresent(String.self, forKey: .squarePublishCost)
            squareRangeCostSm = try values.decodeIfPresent(String.self, forKey: .squareRangeCostSm)
            squareRangeCostRMB = try values.decodeIfPresent(String.self, forKey: .squareRangeCostRMB)
            reportCost = try values.decodeIfPresent(String.self, forKey: .reportCost)
            finishAwardPercent = try values.decodeIfPresent(String.self, forKey: .finishAwardPercent)
            finishAwardMax = try values.decodeIfPresent(String.self, forKey: .finishAwardMax)
            finishAwardMaxDaily = try values.decodeIfPresent(String.self, forKey: .finishAwardMaxDaily)
            signAwardFirst = try values.decodeIfPresent(String.self, forKey: .signAwardFirst)
            signAwardMax = try values.decodeIfPresent(String.self, forKey: .signAwardMax)
            registerAward = try values.decodeIfPresent(String.self, forKey: .registerAward)
            authAward = try values.decodeIfPresent(String.self, forKey: .authAward)
            taskValidTime = try values.decodeIfPresent(String.self, forKey: .taskValidTime)
            taskCompleteTime = try values.decodeIfPresent(String.self, forKey: .taskCompleteTime)
        }
        
    }
    
}

