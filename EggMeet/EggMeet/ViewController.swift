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
    
    func setupView(){
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        
        view.addSubview(appleButton)
        NSLayoutConstraint.activate([appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)])
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

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            
            let userIdentifer = credentials.user
            NSLog("userID : \(credentials.user)")
            // token과 user 정보가 담겨있는 User 객체
            let user = User(credentials: credentials)
            // 받아온 user 정보 debug 결과 로그로 출력
            NSLog(user.debugDescription)
            
            // api 주소
            var mainAddress :String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
            let apiURL: String = "http://" + mainAddress + "/auth/login"
            
 
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
            } catch {
                print("http Body Error")
            }
            
            AF.request(request).responseString{ (responce) in
                switch responce.result {
                case .success:
                    print("Post 성공")
                    guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpNickNameVC") as? SignUpNickNameVC else {return}
                    self.navigationController?.pushViewController(nextVC, animated: true)
                case .failure(let error):
                    print("error")
                }
                
            }
            

            
            
                
        
            // segue 가 들어갈 공간. Navigation 으로 segue 한다.
            
            
        default: break
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print("something bad happened", error)
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}



