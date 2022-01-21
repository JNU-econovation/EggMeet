//
//  SignUpSelfIntroduceViewController.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//

import Foundation
import UIKit

class SignUpSelfIntroduceVC: UIViewController {
    @IBOutlet weak var selfIntroduceTextView: UITextView!
    @IBOutlet weak var textViewCountLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    let selfIntroduceKey = "description"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextViewStyle()
        selfIntroduceTextView.layer.borderColor = UIColor.systemGray4.cgColor
        selfIntroduceTextView.layer.cornerRadius = 10
        selfIntroduceTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "자기소개";
    }
    
    @IBAction func windSignUpMentoAreaSelectionView(_ sender: Any){
        ud.set(self.selfIntroduceTextView.text, forKey: selfIntroduceKey)
        
        if self.selfIntroduceTextView.text.count != 0 {
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentoAreaSelectionVC") as? SignUpMentoAreaSelectionVC else {return}
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @IBAction func skipAndWindSignUpMentoAreaSelectionView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentoAreaSelectionVC") as? SignUpMentoAreaSelectionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setTextViewStyle(){
        self.selfIntroduceTextView.layer.borderWidth = 1.0
        self.selfIntroduceTextView.layer.borderColor = UIColor.black.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.selfIntroduceTextView.endEditing(true)
        }
    
    @IBAction func windPopupView(_ sender: Any){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpIntroducePopUpVC") as! SignUpIntroducePopUpVC
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}

extension SignUpSelfIntroduceVC : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.textViewCountLabel.text = "\(self.selfIntroduceTextView.text.count)/500"
        if selfIntroduceTextView.text.count != 0 {
            self.nextButton.setImage(UIImage(named: "enable_next_button"), for: .normal)
        } else {
            self.nextButton.setImage(UIImage(named: "next_button_disable"), for: .normal)
        }
        if selfIntroduceTextView.text.count > 500{
            self.selfIntroduceTextView.deleteBackward()
        }
    }
}
