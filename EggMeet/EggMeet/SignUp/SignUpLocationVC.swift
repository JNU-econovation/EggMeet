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
    @IBOutlet weak var locationCategoryButton: UIButton!
    @IBOutlet weak var locationDetailCategoryButton: UIButton!
    
    var list = ["전체", "서울", "부산", "대구" ,"광주", "대전", "울산", "인천", "경기", "강원", "충남", "충북", "세종", "전남", "전북", "경북", "경남", "제주"]
    var selectCellIndex: Int = 0
    var isTouchedLocationButton: Bool = true
    var isTouchedDetailLocationButton: Bool = false
    
    let locationAreaDD: DropDown = DropDown()
    let locationKey = "location"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collcectionView.delegate = self
        self.collcectionView.dataSource = self
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "활동지역";
    }
    
    func setCollectionView(){
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
    
    @IBAction func touchLocationCategoryButton(_ sender: Any) {
        
        switch isTouchedLocationButton {
        case true :
            locationCategoryButton.setImage(UIImage(named: "location_category_deselcted"), for: .normal)
            isTouchedLocationButton = false
            collcectionView.isHidden = true
        case false :
            locationCategoryButton.setImage(UIImage(named: "location_category_selected"), for: .normal)
            isTouchedLocationButton = true
            collcectionView.isHidden = false
        }
    }
    
    @IBAction func touchLocationDetailCategoryButton(_ sender: Any) {
        switch isTouchedDetailLocationButton {
        case true :
            locationDetailCategoryButton.setImage(UIImage(named: "location_detail_category_deselcted"), for: .normal)
            isTouchedDetailLocationButton = false
        case false :
            locationDetailCategoryButton.setImage(UIImage(named: "location_detail_category_selected"), for: .normal)
            isTouchedDetailLocationButton = true
        }
    }
}

extension SignUpLocationVC {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return list.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LocationCollectionViewCell
            
            cell.locationLabel.text = list[indexPath.row]
            cell.locationLabel.textColor = .gray
            cell.layer.cornerRadius = 2
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 1
            
            if(indexPath.row == selectCellIndex){
                cell.layer.borderColor = UIColor.black.cgColor
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            }
            cell.isSelected = indexPath.row == selectCellIndex
            
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
        print("click cell = \(list[indexPath.row])")
        let cell = collectionView.cellForItem(at: indexPath) as! LocationCollectionViewCell
        ud.set(list[indexPath.row], forKey: locationKey)
        selectCellIndex = indexPath.row
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
