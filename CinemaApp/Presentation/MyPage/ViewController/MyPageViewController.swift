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
            
        // MARK: - myProfile
        case .myProfile:
            print("userName: \(UserDefaults.standard.value(forKey: "userName")) / \(UserDefaults.standard.value(forKey: "userID"))")
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MyProfileTableViewCell.identifier,
                for: indexPath) as? MyProfileTableViewCell else {
                return UITableViewCell()
            }
            
            print("cell: \(cell.userNameLabel.text)")
            
             // 회원정보 수정 버튼 눌렀을 때 실행할 클로저 정의
            cell.editUserInfoButton = { [unowned self] in
                let registerVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
                self.present(registerVC, animated: true) //회원가입 뷰 present
            }
            
            // 로그아웃 버튼 눌렀을 때 실행할 클로저 정의
            cell.logoutButton = { [unowned self] in
                let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                self.navigationController?.pushViewController(loginVC, animated: true) //로그인 뷰 push
            }
            
            
            
            cell.configure()
            cell.selectionStyle = .none
            cell.backgroundColor = .red
            return cell
        
        // MARK: - myMenu
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
    
    
}
