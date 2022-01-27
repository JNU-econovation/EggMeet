//
//  RegisterUser.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/07.
//

import Foundation
import UIKit
import Alamofire

// JSON으로 보낼 구조체
// isOnlineAvailable 로 변수명 변경 (offline도)
struct RegisterUser {
    let age: Int?
    let description: String?
    let email: String?
    let location: String?
    let loginType: String?
    let menteeCategory: String?
    let menteeDescription: String?
    let mentorCareer: String?
    let mentorCategory: String?
    let mentorDescription: String?
    let mentorGrowthPoint: Int?
    let mentorLink: String?
    let nickname: String?
    let isOfflineAvailable: Bool
    let isOnlineAvailable: Bool
    let phoneNumber: String?
    let pictureIndex: Int?
    let role: String?
    let sex: String?
    let socialToken: String?
    let ud = UserDefaults.standard
    
    init(){
        
        self.age = ud.integer(forKey: "age")
        self.description = ud.string(forKey: "description")
        self.email = ud.string(forKey: "email")
        self.location = ud.string(forKey: "location")
        self.loginType = ud.string(forKey: "loginType")
        self.menteeCategory = ud.string(forKey: "menteeCategory")
        self.menteeDescription = ud.string(forKey: "menteeDescription")
        self.mentorCareer = ud.string(forKey: "mentorCareer")
        self.mentorCategory = ud.string(forKey: "mentorCategory")
        self.mentorDescription = ud.string(forKey: "mentorDescription")
        self.mentorGrowthPoint = ud.integer(forKey: "growthPoint")
        self.mentorLink = ud.string(forKey: "mentorLink")
        self.nickname = ud.string(forKey: "nickname")
        self.isOfflineAvailable = ud.bool(forKey:"isOfflineAvailable")
        self.isOnlineAvailable = ud.bool(forKey: "isOnlineAvailable")
        self.phoneNumber = ud.string(forKey: "phoneNumber")
        self.pictureIndex = ud.integer(forKey: "pictureIndex")
        self.role = ud.string(forKey: "role")
        self.sex = ud.string(forKey: "sex")
        self.socialToken = ud.string(forKey: "socialToken")
    }
    
    func setRegisterParameters() -> [String: Any]{
        let JSONDictionary: [String: Any] = [
            "nickname": ud.string(forKey: "nickname") ?? "Yunseong",
            "age": ud.integer(forKey: "age") ?? 24,
            "sex": "\(Sex(rawValue: ud.string(forKey: "sex")!)!)" ?? "UNDEFINED",
            "email": ud.string(forKey: "email") ?? "default@naver.com",
            "location": "\(Location(rawValue: ud.string(forKey: "location")!)!)" ?? "GWANGJU_BUKGU",
            "description": ud.string(forKey: "description") ?? "",
            "pictureIndex": 0 ?? 1,
            "isOnlineAvailable": ud.bool(forKey: "isOnlineAvailable"),
            "isOfflineAvailable": ud.bool(forKey:"isOfflineAvailable"),
            "mentorCategory": "\(Category(rawValue: ud.string(forKey: "mentorCategory")!)!)" ,
            "mentorDescription": ud.string(forKey: "mentorDescription") ?? "test",
            "mentorCareer": ud.string(forKey: "mentorCareer") ?? "test",
            "mentorLink": ud.string(forKey: "mentorLink") ?? "test",
            "mentorGrowthPoint": ud.integer(forKey: "growthPoint") ?? 1,
            "menteeCategory": "\(Category(rawValue: ud.string(forKey: "menteeCategory")!)!)"  ?? "IT_WEB",
            "menteeDescription": ud.string(forKey: "menteeDescription") ?? "test",
            "loginType": ud.string(forKey: "loginType") ?? "APPLE",
            "socialToken": ud.string(forKey: "socialToken") ?? "",
            "role": ud.string(forKey: "role") ?? "ROLE_USER"
        ]
        NSLog("dummyData : \(JSONDictionary)")
        return JSONDictionary
    }
    
    func setDummyDataRegisterParameters() -> [String: Any]{
        let JSONDictionary: [String: Any] = [
            "nickname": "Songa",
            "age": 24,
            "sex": "FEMALE",
            "email": "1998thddk@gmail.com",
            "location": "GWANGJU_BUKGU",
            "description": "안녕하세요. 저는 코딩에 관심이 많은 대학생입니다. 백엔드 공부도 해보고 싶고 영어 공부도 배워보고 싶어요.",
            "pictureIndex": 0,
            "isOnlineAvailable": true,
            "isOfflineAvailable": true,
            "mentorCategory": "IT_WEB",
            "mentorDescription": "스위프트 멘토로써 활동하고 싶습니다.",
            "mentorCareer": "iOS 프로젝트 진행 경험",
            "mentorLink": "https://songa.com",
            "mentorGrowthPoint": 5,
            "menteeCategory": "IT_WEB",
            "menteeDescription": "영어 배워서 해외 생활 하고 싶습니다.",
            "loginType": "APPLE",
            "socialToken": ud.string(forKey: "socialToken") ?? "",
            "role": "ROLE_USER"
        ]
        NSLog("dummyData : \(JSONDictionary)")
        return JSONDictionary
    }
    
    func requestRegisterInformation(){
        var mainAddress :String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://" + mainAddress + "/auth/register"
        let loginParam = setRegisterParameters() as Dictionary
        
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: loginParam, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString{ (response) in
            switch response.result {
            case .success:
                print("Post 성공")
                print("debugDescription:\(response.debugDescription)")
            case .failure(let error):
                print("error \(error)")
                print("debugDescription:\(response.debugDescription)")
            }
        }
    }
}

