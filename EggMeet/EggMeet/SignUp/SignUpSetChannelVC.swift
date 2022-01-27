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
    @IBOutlet weak var nextButton: UIButton!
    
    var isOnlineChecked : Bool = false
    var isOfflineChecked : Bool = false
    
    let isOnlineAvailableKey = "isOnlineAvailable"
    let isOfflineAvailableKey = "isOfflineAvailable"
    
    let ud = UserDefaults.standard
        
    override func viewDidLoad() {
        ud.set(isOnlineChecked, forKey: isOnlineAvailableKey)
        ud.set(isOfflineChecked, forKey: isOfflineAvailableKey)
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func windSignUpCheckTermsOfServiceView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpCheckTermsOfServiceVC") as? SignUpCheckTermsOfServiceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpCheckTermsOfServiceView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpCheckTermsOfServiceVC") as? SignUpCheckTermsOfServiceVC else {return}
        ud.set(false, forKey: isOnlineAvailableKey)
        ud.set(false, forKey: isOfflineAvailableKey)
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @IBAction func touchUpOnlineButton(_ sender: UIButton){
        isOnlineChecked = !isOnlineChecked
        ud.set(isOnlineChecked, forKey: isOnlineAvailableKey)
        sender.isSelected.toggle()
    }
    
    @IBAction func touchUpOfflineButton(_ sender: UIButton){
        isOfflineChecked = !isOfflineChecked
        ud.set(isOfflineChecked, forKey: isOfflineAvailableKey)
        sender.isSelected.toggle()
    }
}
