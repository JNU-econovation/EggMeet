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
    
    func getUserMentorData() -> [UserMentorResponseModel] {
        let url = getAPI_URL(target: "/user/mentor")
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

                    for data in dataList {
                        guard let nickname = data["nickname"] as? String,  let age = data["age"] as? Int, let growthPoint = data["growthPoint"] as? Int, let id = data["id"] as? Int, let mentorRating = data["mentorRating"] as? Float else {
                            print("error happened")
                            return
                        }
                        
                        mentorList.append(UserMentorResponseModel.init(age: age, category: .PROGRAMMING_C, growthPoint: growthPoint, id: id, location: .ALL, mentorRating: mentorRating, nickname: nickname, isOfflineAvailable: false, isOnlineAvailable: true, sex: .UNDEFINED))
                        print(data)
                    }
                } catch {print(error)}
            case .failure(let error):
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = dataResponse.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
            }
        }
        print(mentorList)
        return mentorList
    }
    
    func getAPI_URL(target: String) -> String{
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://"+mainAddress + target
        return apiURL
    }
}
