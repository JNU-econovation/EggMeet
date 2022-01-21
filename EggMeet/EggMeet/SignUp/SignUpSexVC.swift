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
        setGenderRadioButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "성별";
    }
    
    func setGenderRadioButtons(){
        let womanRadioButton = DLRadioButton()
        let manradioButton = DLRadioButton()
        let undefinedButton = DLRadioButton()
        
        womanRadioButton.setTitle("여성", for: .normal)
        manradioButton.setTitle("남성", for: .normal)
        undefinedButton.setTitle("밝히지 않음", for: .normal)
        
        womanRadioButton.icon = UIImage(named: "gender_woman_deselected") ?? womanRadioButton.icon
        manradioButton.icon = UIImage(named: "gender_man_deselcted") ?? manradioButton.icon
        undefinedButton.icon = UIImage(named: "gender_undefined_deselected") ?? undefinedButton.icon
        
        womanRadioButton.iconSelected = UIImage(named: "gender_woman") ?? womanRadioButton.iconSelected
        manradioButton.iconSelected = UIImage(named: "gender_man_selcted") ?? manradioButton.iconSelected
        undefinedButton.iconSelected = UIImage(named: "gender_undefined_selected") ?? undefinedButton.iconSelected
        
        womanRadioButton.frame = CGRect(x: 0, y: 0, width: 76, height: 74)
        manradioButton.frame = CGRect(x: 99, y: 0, width: 76, height: 74)
        undefinedButton.frame = CGRect(x: 200, y: 0, width: 76, height: 74)
        
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
