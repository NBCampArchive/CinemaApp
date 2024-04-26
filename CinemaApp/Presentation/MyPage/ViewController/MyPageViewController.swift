//
//  MyPageViewController.swift
//  CinemaApp
//
//  Created by 유림 on 4/25/24.
//

import UIKit

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [ViewModelItem] = [ProfileItem(),
                                  MyMenuItem(menuTitle: "예매 내역"),
                                  MyMenuItem(menuTitle: "찜한 영화")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 로그인 뷰 업데이트 Notification Observer
        print("userDefault Id:", UserDefaults.standard.string(forKey: "userID"))
        NotificationCenter.default.addObserver(self, selector: #selector(viewUpdate(notification:)), name: Notification.Name.userDefaultsChanged, object: nil)
    }
    // MARK: - notification으로 실행시킬 함수
    @objc func viewUpdate(notification: Notification) {
        print("데이터 리로드!")
        self.tableView.reloadData()
    }
    
}



extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("행 수: \(items.count)")
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        print("item: \(item)")
        
        switch item.type {
            
            // MARK: - myProfile cell 커스터마이징
        case .myProfile:
            print("userName: \(UserDefaults.standard.value(forKey: "userName")) / \(UserDefaults.standard.value(forKey: "userID"))")
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MyProfileTableViewCell.identifier,
                for: indexPath) as? MyProfileTableViewCell else {
                return UITableViewCell()
            }
            // cell UI
            cell.configure()
            cell.selectionStyle = .none
            
            // 회원정보 수정 버튼 눌렀을 때 실행할 클로저 정의
            cell.editUserInfoButton = { [unowned self] in
                let registerVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
                self.present(registerVC, animated: true) //회원가입 뷰 present
            }
            
            // 로그아웃 버튼 눌렀을 때 실행할 클로저 정의
            cell.logoutButton = { [unowned self] in
                self.navigationController?.popToRootViewController(animated: true) //root view인 로그인 뷰로 이동
                //self.navigationController?.pushViewController(loginVC, animated: true) //로그인 뷰 push
            }
            return cell
            
            // MARK: - myMenu cell 커스터마이징
        case .myMenu:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "myMenuCell", for: indexPath) as? myMenuTableViewCell else {
                return UITableViewCell()
            }
            cell.item = item
            cell.configure()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
    // MARK: - 메뉴 셀 선택했을 때 화면 이동 이벤트 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // myMenu cell에만 이벤트 등록! (indexPath.row == 0 은 profileCell임)
        guard indexPath.row > 0 else { return }
        
        let item = self.items[indexPath.row] as! MyMenuItem
        let menuTitle = item.menuTitle
        
        // TODO: menuTitle 페이지로 이동하는 함수 작성
        switch menuTitle {
        case "예매 내역" :
            print("case: 예매 내역")
            // 예매 내역 페이지로 이동
            if let navController = self.navigationController {
                let pushVC = UIStoryboard(name: "ReservationList", bundle: nil).instantiateViewController(withIdentifier: "ReservationListViewController")
                navController.pushViewController(pushVC, animated: true)
            } else {
                print("Navigation controller does not exist")
            }

        case "찜한 영화" :
            print("case: 찜한 영화")
            // 찜한 영화 페이지로 이동
            if let navController = self.navigationController {
                let pushVC = UIStoryboard(name: "LikeMovie", bundle: nil).instantiateViewController(withIdentifier: "LikeMovieViewController")
                navController.pushViewController(pushVC, animated: true)
            } else {
                print("Navigation controller does not exist")
            }
            
        default :
            print("아무것도 실행 안함")
        }
    }
    
}
