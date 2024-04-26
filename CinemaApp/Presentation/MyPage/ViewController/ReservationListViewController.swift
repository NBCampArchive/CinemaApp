//
//  ReservationListViewController.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/26/24.
//

import UIKit

class ReservationListViewController: UIViewController{
    
    @IBOutlet weak var reservationListTableView: UITableView!
    
    var reservationList: [Reservation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reservationListTableView.dataSource = self
        reservationListTableView.delegate = self
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        reservationListTableView.backgroundColor = UIColor(named: "BackgroundColor")
        
        navigationItem.title = "예매 내역"
        
        reservationList = loadReservations()
    }
    
    func loadReservations() -> [Reservation] {
        if let data = UserDefaults.standard.data(forKey: "reservations") {
            let decoder = JSONDecoder()
            if let reservations = try? decoder.decode([Reservation].self, from: data) {
                return reservations
            }
        }
        return []
    }
}

extension ReservationListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationListViewCell", for: indexPath) as? ReservationListViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(reservation: reservationList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
