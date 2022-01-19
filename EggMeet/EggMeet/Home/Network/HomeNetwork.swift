//
//  HomeNetwork.swift
//  EggMeet
//
//  Created by asong on 2022/01/13.
//

import Foundation
import Alamofire

struct HomeNetwork {
    static let shared = HomeNetwork()
    let ud = UserDefaults.standard
    
    func getUserMentorData(location: String, category: String, growthPointSort: String, sex: String, isOnlineAvailable: Bool, isOfflineAvailable: Bool, age: Int, completion: @escaping ([UserMentorResponseModel]) -> Void)  {
        var url: String = ""
        if age == 0 {
            url = getAPI_URL(target: "/user/mentor")+"?location=\(location)&sex=\(sex)&isOnlineAvailable=\(isOnlineAvailable)&isOfflineAvailble=\(isOfflineAvailable)&category=\(category)&growthPointSort=\(growthPointSort)"
        }else{
            url = getAPI_URL(target: "/user/mentor")+"?location=\(location)&sex=\(sex)&age=\(age)&isOnlineAvailable=\(isOnlineAvailable)&isOfflineAvailble=\(isOfflineAvailable)&category=\(category)&growthPointSort=\(growthPointSort)"
        }
       
        NSLog("api URL : \(url)")
        
        let accessToken: String = ud.string(forKey: "accessToken")!
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        var mentorList: [UserMentorResponseModel] = [UserMentorResponseModel]()
        
        AF.request(request).responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(let value):
                do {
                    let dataList = try JSONSerialization.jsonObject(with: value, options: []) as! [[String: Any]]
                    
                    print(dataList)
                    
                    for data in dataList {
                        guard let nickname = data["nickname"] as? String,  let age = data["age"] as? Int, let growthCost = data["growthCost"] as? Int, let id = data["id"] as? Int, let mentorRating = data["mentorRating"] as? Float, let offlineAvailable = data["offlineAvailable"] as? Int, let onlineAvailable = data["onlineAvailable"] as? Int, let location = data["location"] as? String, let category = data["category"] as? String, let sex = data["sex"] as? String else {
                            print("error happened")
                            return
                        }
                        
                        mentorList.append(UserMentorResponseModel.init(age: age, category: Category.init(rawValue: category) ?? .PROGRAMMING_C, growthCost: growthCost, id: id, location: Location.init(rawValue: location) ?? .ALL, mentorRating: mentorRating, nickname: nickname, offlineAvailable: offlineAvailable, onlineAvailable: onlineAvailable, sex: Sex.init(rawValue: sex) ?? .UNDEFINED))
                    }
                    
                    completion(mentorList)
                } catch {print(error.localizedDescription)}
            case .failure(let error):
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = dataResponse.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
            }
        }
    }
    
    func getAPI_URL(target: String) -> String{
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://"+mainAddress + target
        return apiURL
    }
}
extension HomeNetwork {
    func getUserMenteeData(location: String, category: String, sex: String, isOnlineAvailable: Bool, isOfflineAvailable: Bool, age: Int, completion: @escaping ([UserMentorResponseModel]) -> Void)  {
        var url: String = ""
        if age == 0 {
            url = getAPI_URL(target: "/user/mentee")+"?location=\(location)&sex=\(sex)&isOnlineAvailable=\(isOnlineAvailable)&isOfflineAvailble=\(isOfflineAvailable)&category=\(category)"
        }else{
            url = getAPI_URL(target: "/user/mentee")+"?location=\(location)&sex=\(sex)&age=\(age)&isOnlineAvailable=\(isOnlineAvailable)&isOfflineAvailble=\(isOfflineAvailable)&category=\(category)"
        }
        NSLog("api URL : \(url)")
        
        let accessToken: String = ud.string(forKey: "accessToken")!
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        var menteeList: [UserMentorResponseModel] = [UserMentorResponseModel]()
        
        AF.request(request).responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(let value):
                do {
                    
                    let dataList = try JSONSerialization.jsonObject(with: value, options: []) as! [[String: Any]]
                    
                    print(dataList)
                    
                    for data in dataList {
                        guard let nickname = data["nickname"] as? String,  let age = data["age"] as? Int, let id = data["id"] as? Int, let mentorRating = data["menteeRating"] as? Float, let offlineAvailable = data["offlineAvailable"] as? Int, let onlineAvailable = data["onlineAvailable"] as? Int, let location = data["location"] as? String, let category = data["category"] as? String, let sex = data["sex"] as? String else {
                            print("error happened")
                            return
                        }
                        
                        menteeList.append(UserMentorResponseModel.init(age: age, category: Category.init(rawValue: category) ?? .PROGRAMMING_C, growthCost: 0, id: id, location: Location.init(rawValue: location) ?? .ALL, mentorRating: mentorRating, nickname: nickname, offlineAvailable: offlineAvailable, onlineAvailable: onlineAvailable, sex: Sex.init(rawValue: sex) ?? .UNDEFINED))
                    }
                    completion(menteeList)
                } catch {print(error)}
            case .failure(let error):
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = dataResponse.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
            }
        }
    }
}
