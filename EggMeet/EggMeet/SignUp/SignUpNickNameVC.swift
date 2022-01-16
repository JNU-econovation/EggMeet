//
//  SignUpNickName.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//
import Alamofire
import Foundation
import UIKit

class SignUpNickNameVC: UIViewController {
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nicknameWarningLabel: UILabel!
    let nicknameKey = "nickname"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "닉네임";
        self.navigationController?.navigationBar.tintColor = .black
        print("viewDidload")
    }
    
    @IBAction func windSignUpLocationView(_ sender: Any){
        ud.set(self.nicknameTextField.text, forKey: nicknameKey)
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpAgeVC") as? SignUpAgeVC else {return}
        print("실행")
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @IBAction func checkNicknameAvailable(){
        var name: String = self.nicknameTextField.text! ?? ""
        print(name)
        if self.nicknameTextField.text != nil {
            print(self.nicknameTextField.text!)
        }else{
            print("nil")
        }
            //접근하고자 하는 URL 정보
        /*
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let url: String = "http://"+mainAddress + "/auth/user/name"+"?name=\(name)"
        print(url)
        if verifyUrl(urlString: url) {
            //위의 URL와 파라미터를 담아서 POST 방식으로 통신하며, statusCode가 200번대(정상적인 통신) 인지 유효성 검사 진행
            let alamo = AF.request(url, method: .get, parameters: nil).validate(statusCode: 200..<300)
            
            //결과값으로 문자열을 받을 때 사용
            alamo.responseString() { response in
                switch response.result
                {
                //통신성공
                case .success(let value):
                    print("value: \(value)")
                    
                //통신실패
                case .failure(let error):
                    print("error: \(String(describing: error.errorDescription))")
                }
            }
        }else{
            print("URL 유효하지 않음")
        }*/
    
   
    }
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }

}

extension SignUpNickNameVC {
    @IBAction func checkNicknameAvailable(completion: @escaping (Bool) -> Void)  {
        var name: String = ""
        if self.nicknameTextField.text != nil {
            name = self.nicknameTextField.text!
        } else {
            self.nicknameWarningLabel.text = "닉네임을 입력해주세요."
            return
        }
        let url = getAPI_URL(target: "/auth/user/name")+"?name=\(name)"
        NSLog("api URL : \(url)")
        
        let accessToken: String = ud.string(forKey: "accessToken")!
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        var nicknameIsAvailable = true
        
        AF.request(request).responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(let value):
                do {
                    
                    let data = try JSONSerialization.jsonObject(with: value, options: []) as! [String: Any]
                    
                    guard let isAvailable = data["nickname"] as? Bool else {
                        print("error happened")
                        return }
                    
                    completion(nicknameIsAvailable)
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
    }
    
    func getAPI_URL(target: String) -> String{
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://"+mainAddress + target
        return apiURL
    }
}
