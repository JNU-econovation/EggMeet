//
//  SignUpSetMenteeAreaDescriptionVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpSetMenteeAreaDescriptionVC : UIViewController{
    
    @IBOutlet weak var menteeAreaDescriptionTextView: UITextView!
    
    let ud = UserDefaults.standard
    let menteeAreaDescriptionKey: String = "menteeAreaDescription"
    
    override func viewDidLoad() {
        buildTextViewStyle()
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.menteeAreaDescriptionTextView.endEditing(true)
        }

    @IBAction func windSignUpSetChannelView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetChannelVC") as? SignUpSetChannelVC else {return}
        ud.set(self.menteeAreaDescriptionTextView.text, forKey: menteeAreaDescriptionKey)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpSetChannelView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetChannelVC") as? SignUpSetChannelVC else {return}
        self.menteeAreaDescriptionTextView.text = ""
        ud.set("", forKey: menteeAreaDescriptionKey)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func buildTextViewStyle(){
        self.menteeAreaDescriptionTextView.layer.borderWidth = 1.0
        self.menteeAreaDescriptionTextView.layer.borderColor = UIColor.black.cgColor
    }
}
