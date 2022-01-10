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
    let age: String?
    let description: String?
    let email: String?
    let location: String?
    let loginType: String?
    let menteeCategory: String?
    let menteeDescription: String?
    let mentorCareer: String?
    let mentorCategory: String?
    let mentorDescription: String?
    let mentorGrowthPoint: String?
    let mentorLink: String?
    let name: String?
    let offlineAvailable: Bool
    let onlineAvailable: Bool
    let phoneNumber: String?
    let pictureIndex: String?
    let role: String?
    let sex: String?
    let socialToken: String?
    let ud = UserDefaults.standard
    
    init(){
        self.age = ud.string(forKey: "age")
        self.description = ud.string(forKey: "description")
        self.email = ud.string(forKey: "email")
        self.location = ud.string(forKey: "location")
        self.loginType = ud.string(forKey: "loginType")
        self.menteeCategory = ud.string(forKey: "menteeAreaCategory")
        self.menteeDescription = ud.string(forKey: "menteeAreaDescription")
        self.mentorCareer = ud.string(forKey: "mentorAreaCareer")
        self.mentorCategory = ud.string(forKey: "mentorAreaCategory")
        self.mentorDescription = ud.string(forKey: "mentorAreaDescription")
        self.mentorGrowthPoint = ud.string(forKey: "growthPoint")
        self.mentorLink = ud.string(forKey: "mentorAreaLink")
        self.name = ud.string(forKey: "name")
        self.offlineAvailable = ud.bool(forKey:"offlineAvailable")
        self.onlineAvailable = ud.bool(forKey: "onlineAvailable")
        self.phoneNumber = ud.string(forKey: "phoneNumber")
        self.pictureIndex = ud.string(forKey: "pictureIndex")
        self.role = ud.string(forKey: "role")
        self.sex = ud.string(forKey: "sex")
        self.socialToken = ud.string(forKey: "socialToken")
    }
    
    func setRegisterParameters() -> [String: Any]{
        let JSONDictionary: [String: Any] = [
            "age": self.age ?? "",
            "description": self.description ?? "",
            "email": self.email ?? "",
            "location": self.location ?? "",
            "loginType": self.loginType ?? "",
            "menteeCategory": self.menteeCategory ?? "",
            "menteeDescription": self.menteeDescription ?? "",
            "mentorCareer": self.mentorCareer ?? "",
            "mentorCategory": self.mentorCategory ?? "",
            "mentorDescription": self.mentorDescription ?? "",
            "mentorGrowthPoint": self.mentorGrowthPoint ?? "",
            "mentorLink": self.mentorLink ?? "",
            "name": self.name ?? "",
            "offlineAvailable": self.offlineAvailable,
            "onlineAvailable": self.onlineAvailable,
            "pictureIndex": self.pictureIndex ?? "",
            "role": self.role ?? "",
            "sex": self.sex ?? "",
            "socialToken": self.socialToken ?? ""
        ]
        
        return JSONDictionary
    }
    
    func setDummyDataRegisterParameters() -> [String: Any]{
        let JSONDictionary: [String: Any] = [
            "name": "test",
            "age": 10,
            "sex": "MALE",
            "email": "dbsdltjd123@naver.com",
            "location": "ALL",
            "description": "test",
            "pictureIndex": 0,
            "onlineAvailable": true,
            "offlineAvailable": true,
            "mentorCategory": "PROGRAMMING_C",
            "mentorDescription": "test",
            "mentorCareer": "test",
            "mentorLink": "test",
            "mentorGrowthPoint": 5,
            "menteeCategory": "PROGRAMMING_CPP",
            "menteeDescription": "test",
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
        let loginParam = setDummyDataRegisterParameters() as Dictionary
        
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: loginParam, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString{ (responce) in
            switch responce.result {
            case .success:
                print("Post 성공")
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
}

