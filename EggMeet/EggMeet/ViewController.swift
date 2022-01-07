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
            
            // token과 user 정보가 담겨있는 User 객체
            let user = User(credentials: credentials)
            print(user.debugDescription)
            // api 주소
            if var apiURL = Bundle.main.infoDictionary?["API_URL"] as? String{
                print(apiURL)
            }
        
            
            // 전송할 정보
            let PARAM: Parameters = [
                "loginType": "APPLE",
                "socialToken": user.accessTokenString
            ]
            
            
            
            
            
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

