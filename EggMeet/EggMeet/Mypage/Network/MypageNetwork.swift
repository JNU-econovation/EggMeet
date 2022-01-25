//
//  MypageNetwork.swift
//  EggMeet
//
//  Created by 황지우 on 2022/01/26.
//


import Foundation
import Alamofire


struct MypageNetwork {
 
    static let shared = MypageNetwork()
    let ud = UserDefaults.standard
    
    func getMypageData(completion: @escaping (MypageModel) -> Void)  {
        
        let url = getAPI_URL(target: "/user/profile/me")
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
                    
                    guard let nickname = data["nickname"] as? String,  let growthPoint = data["growthPoint"] as? Int  else {
                        print("error happened")
                        return
                    }
                    
                    var userData: MypageModel = MypageModel(nickname: nickname, growthPoint: growthPoint)
                    
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
    
    func getAPI_URL(target: String) -> String{
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://"+mainAddress + target
        return apiURL
    }
    
}
    /*
    func getMyname(completion : @escaping (NetworkResult<Any>) -> Void) {
    
        let url = getAPI_URL(target: "/user/profile/me")
        NSLog("api URL : \(url)")
        
        let accessToken: String = ud.string(forKey: "accessToken")!
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        let dataRequest = AF.request(url, method: .get, encoding: JSONEncoding.default)
        
        dataRequest.responseData{
            dataResponse in
            switch dataResponse.result{
            case .success :
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            
            case.failure: completion(.pathErr)
                
            }
        }
    
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode{
        case 200: return isValidData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(MypageModel.self, from: data) else {return .pathErr}
        
        return .success(decodedData.data)
    }
}

*/
