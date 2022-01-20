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
    @IBOutlet var textViewCountLabel: UILabel!
    
    let ud = UserDefaults.standard
    let menteeAreaDescriptionKey: String = "menteeAreaDescription"
    
    override func viewDidLoad() {
        buildTextViewStyle()
        super.viewDidLoad()
        // textViewCountLabel.text = "\(menteeAreaDescriptionTextView.text.count)/500"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.menteeAreaDescriptionTextView.endEditing(true)
        }

    @IBAction func windSignUpSetChannelView (_ sender: Any){
        if self.menteeAreaDescriptionTextView.text == "" {
            showAlert()
            return
        }
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
        self.menteeAreaDescriptionTextView.layer.borderColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor
        self.menteeAreaDescriptionTextView.layer.cornerRadius = 12
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "주의", message: "내용을 작성해주세요!", preferredStyle: UIAlertController.Style.alert)
        let cancelButton = UIAlertAction(title: "확인", style: .default , handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}

extension SignUpSetMenteeAreaDescriptionVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textViewCountLabel.text = "\(menteeAreaDescriptionTextView.text.count)/500"
        if menteeAreaDescriptionTextView.text.count != 0 {
            // image 설정
        }else if menteeAreaDescriptionTextView.text.count > 500 {
            menteeAreaDescriptionTextView.deleteBackward()
        } else if menteeAreaDescriptionTextView.text.count == 0 {
            // image 설정
        }
    }
}
