//
//  ViewController.swift
//  EggMeet
//
//  Created by 이윤성 on 2021/12/26.
//

import UIKit
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKUser
import Alamofire
import Foundation

class ViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func windHome(_ sender: Any){
        let sb = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let nextVC = sb.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setupView(){
        
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        appleButton.frame = CGRect(x:0, y:0, width: 272, height: 42)
        appleButton.cornerRadius = 12
        view.addSubview(appleButton)
        NSLayoutConstraint.activate([appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 197),
                                     appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 51),
                                     appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -51),
                                     appleButton.widthAnchor.constraint(equalToConstant: 272),
                                     appleButton.heightAnchor.constraint(equalToConstant: 42)])
        
    }
    
    @objc func didTapAppleButton(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    // segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainVC = segue.destination as? MainViewController, let user = sender as? User{
            mainVC.user = user
        }
    }
    
    // 카카오톡으로 로그인
    @IBAction func onKakaoLoginByAppTouched(_ sender: Any) {
        //카카오 계정으로 로그인
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                }
            }
        
        //토큰 존재 여부 확인
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    /*
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                    }
                    else {
                        //기타 에러
                    }*/
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                }
            }
        }
        else {
            //로그인 필요
        }
        
        
        // 사용자 액세스 토큰 정보 조회
        UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
            if let error = error {
                print(error)
            }
            else {
                print("accessTokenInfo() success.")

                //do something
                _ = accessTokenInfo
                print(accessTokenInfo)
            }
        }
    }

}

extension ViewController: ASAuthorizationControllerDelegate, Encodable {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let ud = UserDefaults.standard
            let user = User(credentials: credentials) // token과 user 정보가 담겨있는 User 객체
            ud.set(user.accessTokenString, forKey: "socialToken")
            NSLog(user.debugDescription)
            // 초기 로그인 시에, email ud에 추가. 이후 email에 접근할 때는 ud를 통해 접근한다.
            if(user.email != "") { user.setEmailLocalDB() }
            
            if(self.isBanUser() == true){
                NSLog("밴 당한 유저입니다.")
                // 밴 유저로 segue
            } else{
                authLoginProcess(user: user)
            }
            
            
        
            // segue 가 들어갈 공간. Navigation 으로 segue 한다.
        default: break
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("something bad happened", error)
    }

    func authLoginProcess(user: User){
        let apiURL = getAPI_URL(target: "/auth/login")
        let loginParam = [
            "loginType": "APPLE",
            "socialToken" : user.accessTokenString
            ] as Dictionary
        
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: loginParam, options: [])
            NSLog("httpBody: \(String(data:request.httpBody!, encoding: .utf8))")       // Log 출력
        } catch {
            NSLog("http Body Error")    // 에러 출력
        }
        
        AF.request(request).responseString{ (response) in
            switch response.result {
            case .success(let res):
                // statusCode 에 따라서 구현
                NSLog("Post 성공")
                NSLog("StatusCode:\(response.response?.statusCode)")
                NSLog("response: \(response.debugDescription)")
                
                // 기존 유저 -> 홈 화면 segue
                if response.response?.statusCode == 200{
                    // accessToken UserDefaults에 저장
                    do {
                        if let data = response.data {
                            guard let jsonData = res.data(using: .utf8) else {return}
                            let token = try! JSONDecoder().decode(LoginTokenModel.self, from: jsonData)
                            print("Finally accessToken : \(token.accessToken)")
                            let accessToken = token.accessToken
                            let ud = UserDefaults.standard
                            ud.set(accessToken, forKey: "accessToken")
                        }
                    } catch {}
                    self.performSegue(withIdentifier: "windLoginHome", sender: self)
                   
                // 신규 유저 -> register 204
                } else{
                    guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpNickNameVC") as? SignUpNickNameVC else {return}
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                
            case .failure(let error):
                NSLog("error \(error)")
            }
        }
    }
    
    func isBanUser() -> Bool{
        var isBannedUser : Bool = false
        let ud = UserDefaults.standard
        let apiURL = getAPI_URL(target: "/auth/user/ban")+"?email=\(ud.string(forKey: "email")!)&loginType=APPLE"
        NSLog("apiURL 확인 : \(apiURL)")
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
    
        AF.request(request).responseString{ (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    let json = String(data: data, encoding: .utf8)
                    NSLog("Response data : \(json)")
                    NSLog("typeof : \(type(of: json))")
                    if json == "false"{
                        NSLog("밴 유저 아님.")
                        isBannedUser = false
                    } else {
                        NSLog("밴 유저임.")
                        isBannedUser = true
                    }
                }
                NSLog("/user/ban GET 성공.")
                NSLog("StatusCode:\(response.response?.statusCode)")
                NSLog("response: \(response.debugDescription)")
            
                // 밴 아닌 유저

            case .failure(let error):
                NSLog("error : \(error)")
                
            }
        }
        return isBannedUser
    }
    
    func getAPI_URL(target: String) -> String{
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://" + mainAddress + target
        return apiURL
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}



