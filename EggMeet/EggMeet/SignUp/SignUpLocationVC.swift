//
//  SignUpLocationViewController.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//

import Foundation
import UIKit
import DropDown

class SignUpLocationVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var locationAreaButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collcectionView: UICollectionView!
    
    var list = ["1", "2", "3", "4" ,"5", "6", "7", "8", "9", "10"]
    
    let locationAreaDD: DropDown = DropDown()
    let locationKey = "location"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collcectionView.delegate = self
        self.collcectionView.dataSource = self
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 7
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset.top = 9
        flowLayout.sectionInset.left = 9
        flowLayout.sectionInset.bottom = 10
        flowLayout.sectionInset.right = 7
        flowLayout.itemSize = CGSize(width: 48, height: 18)
        self.collcectionView.collectionViewLayout = flowLayout
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "활동지역";
    }
    
    @IBAction func windSignUpSelfIntroduceView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSelfIntroduceVC") as? SignUpSelfIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        print("다음으로")
    }
    @IBAction func skipAndWindSignUpSelfIntroduceView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSelfIntroduceVC") as? SignUpSelfIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
        print("건너뛰기")
    }
    
    @IBAction func touchLocationAreaButton(){
        locationAreaDD.dataSource = [ "전체", "서울", "경기", "인천", "강원", "충남", "대전", "충북", "세종", "부산", "울산", "대구", "경북", "경남", "전남", "광주", "전북", "제주", "전국"]
        locationAreaDD.textColor = UIColor.black
        locationAreaDD.selectedTextColor = UIColor.blue
        locationAreaDD.backgroundColor = UIColor.white
        locationAreaDD.show()
        locationAreaDD.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            ud.set(item, forKey: locationKey)
        }
    }
}

extension SignUpLocationVC {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return list.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LocationCollectionViewCell
            
            //cell.backgroundColor = .lightGray
            cell.locationLabel.text = list[indexPath.row]
            cell.locationLabel.textColor = .systemGray3
            //cell.locationLabel.backgroundColor = .yellow
            
            return cell
        }
}

// cell layout
extension SignUpLocationVC: UICollectionViewDelegateFlowLayout {

    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("click index=\(indexPath.row)")
        let cell = collectionView.cellForItem(at: indexPath) as! LocationCollectionViewCell
        //selectStartYearPos = indexPath.row
        
    }

    /*
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width / 5 - 1 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌
        print("collectionView width=\(collectionView.frame.width)")
        print("cell하나당 width=\(width)")
        print("root view width = \(self.view.frame.width)")

        let size = CGSize(width: width, height: 18)
        return size
    }*/
}
