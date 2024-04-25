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
        case .myProfile:
            print("userName: \(UserDefaults.standard.value(forKey: "userName")) / \(UserDefaults.standard.value(forKey: "userID"))")
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MyProfileTableViewCell.identifier,
                for: indexPath) as? MyProfileTableViewCell else {
                print("else 실행됨")
                return UITableViewCell()
            }
            
            print("cell: \(cell.userNameLabel.text)")
            cell.configure()
            cell.selectionStyle = .none
            cell.backgroundColor = .red
            return cell
//            
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
