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
    
    func getHomeData() -> HomeResponseModel {
        let testEmail = "dbsdltjd123@hanmail.net"
        // let url = getAPI_URL(target: "/user") + "?email=\(ud.string(forKey: "email"))"
        let url = getAPI_URL(target: "/user") + "?email=\(testEmail)"
        NSLog("api URL : \(url)")
        
        let accessToken: String = ud.string(forKey: "socialToken")!
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        var homeList: HomeResponseModel = HomeResponseModel.init(age: 0, description: "", location: .ALL, menteeCategory: .PROGRAMMING_C, menteeDescription: "", menteeRating: 0.0, mentorCareer: "", mentorDescription: "", mentorGrowthPoint: 0, mentorLink: "", mentorRating: 0.0, nickname: "", isOfflineAvailable: true, isOnlineAvailable: true, pictureIndex: 0, sex: .UNDEFINED)
        
        AF.request(request).responseJSON { dataResponse in
            switch dataResponse.result {
            case .success(let value):
                do { let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    
                    homeList = try JSONDecoder().decode(HomeResponseModel.self, from: data)
                    print("email : \(homeList.nickname)")
                    print("result : \(homeList.mentorCareer)")
                   
                } catch { }
            case .failure(let error):
                print("실패")
                print("error : \(error)")
            }
        }
        return homeList
    }
    
    func getAPI_URL(target: String) -> String{
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://"+mainAddress + target
        return apiURL
    }
}
