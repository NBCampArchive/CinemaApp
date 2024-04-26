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
            
             //MARK: 회원정보 수정 버튼 눌렀을 때 실행할 함수 선언
            cell.editUserInfoButton = { [unowned self] in
                 //1. 회원가입 뷰 present
                let registerVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
                self.present(registerVC, animated: true)
//                // 2. 이름, id, pw값 텍스트필드에 기본으로 넣기
//                registerVC.nameViewTextField.text = UserDefaults.standard.string(forKey: "userName")
//                registerVC.idViewTextField.text = UserDefaults.standard.string(forKey: "userID")
//                registerVC.pwViewTextField.text = UserDefaults.standard.string(forKey: "userPW")
//                // 3. 가입하기 버튼 타이틀을 "수정하기"로 바꾸기
//                registerVC.registerButton.titleLabel?.text = "수정하기"
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
