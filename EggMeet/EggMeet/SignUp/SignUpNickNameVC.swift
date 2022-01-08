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
    let nicknameKey = "nickname"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "닉네임";
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @IBAction func windSignUpLocationView(_ sender: Any){
        ud.set(self.nicknameTextField.text, forKey: nicknameKey)
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpLocationVC") as? SignUpLocationVC else {return}
        print("실행")
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    func checkNicknameAvailable(){
        //접근하고자 하는 URL 정보
        let URL = "NickNameURL"
    
        //위의 URL와 파라미터를 담아서 POST 방식으로 통신하며, statusCode가 200번대(정상적인 통신) 인지 유효성 검사 진행
        let alamo = AF.request(URL, method: .post, parameters: self.nicknameTextField.text).validate(statusCode: 200..<300)
        
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
    }
    
}
