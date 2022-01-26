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
    
    func getUserMentorData(location: String, category: String, growthPointSort: String, sex: String, isOnlineAvailable: Bool?, isOfflineAvailable: Bool?, age: Int, completion: @escaping ([UserMentorResponseModel]) -> Void)  {
        var url: String = getAPI_URL(target: "/user/mentor")
        url += setParams(location: location, category: category, growthPointSort: growthPointSort, sex: sex, isOnlineAvailable: isOnlineAvailable, isOfflineAvailable: isOfflineAvailable, age: age)
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
                        
                        mentorList.append(UserMentorResponseModel.init(age: setProperAge(age: age), category: Category(rawValue: category)!, growthCost: growthCost, id: id, location: Location.init(rawValue: location) ?? .ALL, mentorRating: mentorRating, nickname: nickname, offlineAvailable: offlineAvailable, onlineAvailable: onlineAvailable, sex: Sex.init(rawValue: sex) ?? .UNDEFINED))
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
    
    
    func setParams(location: String, category: String, growthPointSort: String, sex: String, isOnlineAvailable: Bool?, isOfflineAvailable: Bool?, age: Int) -> String {
        var paramsArr: [String] = []
        if location.count != 0 {
            paramsArr.append("location=\(location)")
        }
        if category.count != 0 {
            paramsArr.append("category=\(category)")
        }
        if growthPointSort.count != 0{
            paramsArr.append("growthPointSort=\(growthPointSort)")
        }
        if sex.count != 0{
            paramsArr.append("sex=\(sex)")
        }
        if isOnlineAvailable == true {
            paramsArr.append("isOnlineAvailable=\(isOnlineAvailable!)")
        }
        if isOfflineAvailable == true {
            paramsArr.append("isOfflineAvailable=\(isOfflineAvailable!)")
        }
        if age != 0 {
            paramsArr.append("age=\(age)")
        }
        
        var parameterString: String = ""
        if paramsArr.count != 0{
            parameterString += "?"
        }
        
        for str in paramsArr {
            parameterString += str + "&"
        }
        if paramsArr.count != 0 {
            parameterString.removeLast()
        }
        print("parameterStr : \(parameterString)")
        return parameterString
    }
    
    func setProperAge(age: Int) -> Int {
        return (age / 10) * 10
    }
}

extension HomeNetwork {
    func getUserMenteeData(location: String, category: String, sex: String, isOnlineAvailable: Bool?, isOfflineAvailable: Bool?, age: Int, completion: @escaping ([UserMentorResponseModel]) -> Void)  {
        var url: String =  getAPI_URL(target: "/user/mentee")
        url += setParams(location: location, category: category, growthPointSort: "", sex: sex, isOnlineAvailable: isOnlineAvailable, isOfflineAvailable: isOfflineAvailable, age: age)
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
                        
                        menteeList.append(UserMentorResponseModel.init(age: setProperAge(age: age), category: Category(rawValue: category)!, growthCost: 0, id: id, location: Location.init(rawValue: location) ?? .ALL, mentorRating: mentorRating, nickname: nickname, offlineAvailable: offlineAvailable, onlineAvailable: onlineAvailable, sex: Sex.init(rawValue: sex) ?? .UNDEFINED))
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

extension HomeNetwork {
    func getSearchMenteeKeywordData(keyword: String, completion: @escaping ([UserMentorResponseModel]) -> Void)  {
      
        let url = getAPI_URL(target: "/user/mentee/search")+"?keyword=\(keyword)"
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        NSLog("api URL : \(url)")
        
        let accessToken: String = ud.string(forKey: "accessToken")!
        var request = URLRequest(url: URL(string: encodedString)!)
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
                        
                        menteeList.append(UserMentorResponseModel.init(age: setProperAge(age: age), category: Category(rawValue: category)!, growthCost: 0, id: id, location: Location.init(rawValue: location) ?? .ALL, mentorRating: mentorRating, nickname: nickname, offlineAvailable: offlineAvailable, onlineAvailable: onlineAvailable, sex: Sex.init(rawValue: sex) ?? .UNDEFINED))
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
    
    func getSearchMentorKeywordData(keyword: String, completion: @escaping ([UserMentorResponseModel]) -> Void)  {
      
        let url = getAPI_URL(target: "/user/mentor/search")+"?keyword=\(keyword)"
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        NSLog("api URL : \(url)")
        
        let accessToken: String = ud.string(forKey: "accessToken")!
        var request = URLRequest(url: URL(string: encodedString)!)
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
                        
                        mentorList.append(UserMentorResponseModel.init(age: setProperAge(age: age), category: Category(rawValue: category)!, growthCost: growthCost, id: id, location: Location.init(rawValue: location) ?? .ALL, mentorRating: mentorRating, nickname: nickname, offlineAvailable: offlineAvailable, onlineAvailable: onlineAvailable, sex: Sex.init(rawValue: sex) ?? .UNDEFINED))
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
}

extension HomeNetwork {
    func getUserProfileData(id: Int, completion: @escaping (HomeProfileModel) -> Void)  {
        
        let url = getAPI_URL(target: "/user/profile")+"?id=\(id)"
        NSLog("api URL : \(url)")
        
        let accessToken: String = ud.string(forKey: "accessToken")!
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        AF.request(request).responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.jsonObject(with: value, options: []) as! [String: Any]
                    
                    print(data)
                    
                    guard let nickname = data["nickname"] as? String,  let age = data["age"] as? Int, let mentorGrowthCost = data["mentorGrowthCost"] as? Int, let mentorRating = data["mentorRating"] as? Float, let offlineAvailable = data["offlineAvailable"] as? Int, let onlineAvailable = data["onlineAvailable"] as? Int, let location = data["location"] as? String, let mentorCategory = data["mentorCategory"] as? String, let sex = data["sex"] as? String, let mentorLink = data["mentorLink"] as? String, let description = data["description"] as? String, let menteeCategory = data["menteeCategory"] as? String, let menteeDescription = data["menteeDescription"] as? String, let menteeRating = data["menteeRating"] as? Float, let mentorCareer = data["mentorCareer"] as? String, let mentorDescription = data["mentorDescription"] as? String else {
                        print("error happened")
                        return
                    }
                    
                    let userData: HomeProfileModel = HomeProfileModel(age: setProperAge(age: age), description: description, location: location, menteeCategory: menteeCategory, menteeDescription: menteeDescription, menteeRating: menteeRating, mentorCareer: mentorCareer, mentorCategory: mentorCategory, mentorDescription: mentorDescription, mentorGrowthCost: mentorGrowthCost, mentorLink: mentorLink, mentorRating: mentorRating , nickname: nickname, isOfflineAvailable: offlineAvailable, isOnlineAvailable: onlineAvailable, pictureIndex: 0, sex: sex)
                    
                    completion(userData)
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
    
}
