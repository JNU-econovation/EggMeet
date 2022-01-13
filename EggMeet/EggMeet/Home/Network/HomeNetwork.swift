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
    
    func getHomeData() {
        let testEmail = "dbsdltjd123@hanmail.net"
        //let url = getAPI_URL(target: "/user") + "?email=\(ud.string(forKey: "email"))"
        let url = getAPI_URL(target: "/user") + "?email=\(testEmail)"
        NSLog("api URL : \(url)")
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        AF.request(request).responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                print("성공")
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                print("value : \(value)")
                print(dataResponse.debugDescription)
               
            case .failure(let error):
                print("실패")
                print("error : \(error)")
                
            }
        }
    }
    
    func getAPI_URL(target: String) -> String{
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://"+mainAddress + target
        return apiURL
    }
    
    func decodeData(data: Data) {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(HomeResponseModel.self, from: data) else { return }
    }
}
