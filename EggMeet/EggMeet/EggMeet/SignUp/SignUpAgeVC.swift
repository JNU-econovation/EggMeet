//
//  SignUpAgeVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/13.
//

import Foundation
import UIKit
import CoreLocation

class SignUpAgeVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var picker: UIPickerView!
    
    let ageKey = "age"
    let ud = UserDefaults.standard
    var selectRow = 0
    var array: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAgePickerContents()
        picker.delegate = self
        picker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "나이";
    }
    
    func setAgePickerContents() {
        for i in 1920...2022{
            array.insert(String(i), at: 0)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectRow = row
        print(selectRow)
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }

    @IBAction func windSignUpSexView(_ sender: Any){
        ud.set(selectRow+1, forKey: ageKey)
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSexVC") as? SignUpSexVC else {return}
        print("실행")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

