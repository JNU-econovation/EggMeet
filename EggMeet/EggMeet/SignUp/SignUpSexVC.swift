//
//  SignUpSex.swift
//  EggMeet
//
//  Created by asong on 2022/01/13.
//

import Foundation
import UIKit
import DLRadioButton

class SignUpSexVC: UIViewController {
    @IBOutlet weak var sexSelectionView: UIView!
    
    let sexKey = "sex"
    let ud = UserDefaults.standard
    var selectedSex: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "성별";
        self.navigationController?.navigationBar.tintColor = .black
        
        setGenderRadioButtons()
    }
    
    func setGenderRadioButtons(){
        let womanRadioButton = DLRadioButton()
        let manradioButton = DLRadioButton()
        let undefinedButton = DLRadioButton()
        
        womanRadioButton.setTitle("여성", for: .normal)
        manradioButton.setTitle("남성", for: .normal)
        undefinedButton.setTitle("밝히지 않음", for: .normal)
        
        // 라디오버튼 이미지로 변경하는 코드
        /*
        radioButton1.icon = UIImage(systemName: "hand.thumbsdown") ?? radioButton1.icon

        radioButton1.iconSelected = UIImage(systemName: "hand.thumbsup") ?? radioButton1.iconSelected */
        
        womanRadioButton.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        manradioButton.frame = CGRect(x: 80, y: 0, width: 70, height: 30)
        undefinedButton.frame = CGRect(x: 160, y: 0, width: 150, height: 30)
        
        womanRadioButton.setTitleColor( .black , for: .normal)
        manradioButton.setTitleColor( .black , for: .normal)
        undefinedButton.setTitleColor( .black , for: .normal)
        
        womanRadioButton.otherButtons.append(manradioButton)
        womanRadioButton.otherButtons.append(undefinedButton)
        
        womanRadioButton.addTarget(self, action: #selector(touchGenderRadioButton(_:)), for: .touchUpInside)
        manradioButton.addTarget(self, action: #selector(touchGenderRadioButton(_:)), for: .touchUpInside)
        undefinedButton.addTarget(self, action: #selector(touchGenderRadioButton(_:)), for: .touchUpInside)
        
        sexSelectionView.addSubview(womanRadioButton)
        sexSelectionView.addSubview(manradioButton)
        sexSelectionView.addSubview(undefinedButton)
        
    }
    
    @objc func touchGenderRadioButton(_ sender:DLRadioButton) {
        print(sender.currentTitle!)
        selectedSex = sender.currentTitle! ?? "밝히지않음"
    }
    
    @IBAction func windSignUpLocationView(_ sender: Any){
        ud.set(selectedSex, forKey: sexKey)
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpLocationVC") as? SignUpLocationVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
