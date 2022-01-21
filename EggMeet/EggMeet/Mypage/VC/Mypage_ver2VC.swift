//
//  Mypage_ver2VC.swift
//  EggMeet
//
//  Created by 황지우 on 2022/01/22.
//

import UIKit

class Mypage_ver2VC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let data = ["성장포인트 충전하기", "약관", "FAQ / 공지사항", "1:1 문의", "설정","개발팀 정보"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        // 헤더 뷰 구성
        
       
        
        header.backgroundColor = .systemYellow
        
        let headerLabel = UILabel(frame:header.bounds)
        headerLabel.text = "테이블뷰 헤더"
        headerLabel.textAlignment = .center
        header.addSubview(headerLabel)
        
       
        tableView.tableHeaderView = header
       
        // Do any additional setup after loading the view.
    }
    


}

extension Mypage_ver2VC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == 0 {
            return IndexPath(row:1, section:proposedDestinationIndexPath.section )
        }
        else {
            return proposedDestinationIndexPath
        }
    }
     */
    
    
    
}

extension Mypage_ver2VC : UITableViewDataSource {
    
  
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120.0
     
     }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "냐냐냐냐옹"
    }
    /*
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.backgroundColor = .systemGray
        return cell
        
    }
}

