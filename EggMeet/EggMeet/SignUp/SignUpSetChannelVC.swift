//
//  SignUpSetChannelVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpSetChannelVC : UIViewController{
    
    @IBOutlet weak var onlineSelectButton: UIButton!
    @IBOutlet weak var offlineSelectButton: UIButton!
    
    var isOnlineChecked : Bool = false
    var isOfflineChecked : Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func windSignUpCheckTermsOfServiceView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpCheckTermsOfServiceVC") as? SignUpCheckTermsOfServiceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpCheckTermsOfServiceView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpCheckTermsOfServiceVC") as? SignUpCheckTermsOfServiceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func touchUpOnlineButton(_ sender: UIButton){
        isOnlineChecked = !isOnlineChecked
        if isOnlineChecked {
            sender.setTitle("온라인 체크", for:.normal)
        } else {
            sender.setTitle("온라인", for: .normal)
        }
    }
    
    @IBAction func touchUpOfflineButton(_ sender: UIButton){
        isOfflineChecked = !isOfflineChecked
        if isOfflineChecked {
            sender.setTitle("직접 대면 체크", for: .normal)
        } else {
            sender.setTitle("직접 대면", for: .normal)
        }
    }
}
