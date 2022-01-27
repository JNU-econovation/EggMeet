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
    var detailList = ["전체", "북구", "서구", "남구", "동구", "광산구"]
    var selectCellIndex: Int = 0
    var isTouchedLocationButton: Bool = true
    var isTouchedDetailLocationButton: Bool = false
    var windNextVCAble: Bool = false
    var selectLocationStr = ""
    var selectDetailLocationStr = ""
    
    let locationAreaDD: DropDown = DropDown()
    let locationKey = "location"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collcectionView.delegate = self
        self.collcectionView.dataSource = self
        setCollectionView()
        ud.set("광주 서구", forKey: locationKey)
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
    
    func setDetailCollectionView(){
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 14
        flowLayout.sectionInset.top = 22
        flowLayout.sectionInset.left = 16
        flowLayout.sectionInset.bottom = 21
        flowLayout.sectionInset.right = 16
        flowLayout.itemSize = CGSize(width: 125, height: 18)
        self.collcectionView.collectionViewLayout = flowLayout
    }
    
    @IBAction func windSignUpSelfIntroduceView(_ sender: Any){
        if windNextVCAble {
          guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSelfIntroduceVC") as? SignUpSelfIntroduceVC else {return}
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    @IBAction func skipAndWindSignUpSelfIntroduceView(_ sender: Any){
        ud.set("GWANGJU_BUKGU", forKey: locationKey)
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSelfIntroduceVC") as? SignUpSelfIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func touchLocationCategoryButton(_ sender: Any) {
        
        switch isTouchedLocationButton {
        case true :
            locationCategoryButton.setImage(UIImage(named: "location_category_deselcted"), for: .normal)
            locationDetailCategoryButton.setImage(UIImage(named: "location_detail_category_selected"), for: .normal)
            isTouchedLocationButton = false
            collcectionView.isHidden = true
        case false :
            locationCategoryButton.setImage(UIImage(named: "location_category_selected"), for: .normal)
            locationDetailCategoryButton.setImage(UIImage(named: "location_detail_category_deselcted"), for: .normal)
            isTouchedLocationButton = true
            isTouchedDetailLocationButton = false
            collcectionView.isHidden = false
            setCollectionView()
            collcectionView.reloadData()
        }
    }
    
    @IBAction func touchLocationDetailCategoryButton(_ sender: Any) {
        switch isTouchedDetailLocationButton {
        case true :
            locationDetailCategoryButton.setImage(UIImage(named: "location_detail_category_deselcted"), for: .normal)
            collcectionView.isHidden = true
            isTouchedDetailLocationButton = false
        case false :
            locationDetailCategoryButton.setImage(UIImage(named: "location_detail_category_selected"), for: .normal)
            isTouchedDetailLocationButton = true
            collcectionView.isHidden = false
            setDetailCollectionView()
            collcectionView.reloadData()
        }
    }
}

extension SignUpLocationVC {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch isTouchedDetailLocationButton {
        case false : return list.count
        case true : return detailList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LocationCollectionViewCell
        switch isTouchedDetailLocationButton {
        case false : cell.locationLabel.text = list[indexPath.row]
        case true : cell.locationLabel.text = detailList[indexPath.row]
        }
        
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
        switch isTouchedDetailLocationButton {
        case false : selectLocationStr = list[indexPath.row]+" "
        case true : selectDetailLocationStr = detailList[indexPath.row]
            windNextVCAble = true
            self.nextButton.setImage(UIImage(named: "enable_next_button"), for: .normal)
            print("select location : \(selectLocationStr+selectDetailLocationStr)")
            ud.set(selectLocationStr + selectDetailLocationStr, forKey: locationKey)
        }
        let cell = collectionView.cellForItem(at: indexPath) as! LocationCollectionViewCell
        selectCellIndex = indexPath.row
    }
}
