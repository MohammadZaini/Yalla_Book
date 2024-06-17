//
//  RoomsViewController.swift
//  YallaBook
//
//  Created by Moe on 22/05/2024.
//

import UIKit
import RealmSwift

class RoomsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var roomLogic = RoomLogic()

    var selectedHotel: HotelData? {
        didSet {
            loadRooms()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerRoomCell()
    }
    
    private func loadRooms() {
        roomLogic.selectedHotel = selectedHotel
        roomLogic.loadRooms()
    }
    
    private func registerRoomCell() {
        tableView.register(UINib(nibName: K.roomCellNibName, bundle: nil), forCellReuseIdentifier: K.roomCellIdentfier)
    }
}

//MARK: - UI Table View Data Source
extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomLogic.rooms?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.roomCellIdentfier, for: indexPath) as! RoomTableViewCell
        
        
        if let room = roomLogic.rooms?[indexPath.row] {
            cell.roomImageView.image = UIImage(named: "hotelImage")
            cell.roomPrice.text = String(room.number)
            cell.roomRating.text = String(room.rating) + " Stars"
            cell.roomType.text  = room.type
            
        }
        
//        let myRoom = RoomData(hotelId: selectedHotel?.hotelId, type: "Delux", price: 89, image: "No image", roomDescription: "A cozy and comfortable room designed for solo travelers. The room features a single bed, a work desk, a flat-screen TV, and an en-suite bathroom with a shower. Ideal for business travelers or short stays.", numberOfBeds: 2, rating: 4, number: 178)
//        
//       
//        do {
//            try realm.write {
//                
//                realm.add(room)
//                
//                selectedHotel?.rooms.append(myRoom)
//                
//                realm.add(hotel!)
//            }
//        }  catch {
//            print(error.localizedDescription)
//        }
        
        //        if let room = rooms?[indexPath.row] {
        //            cell.roomImageView.image = UIImage(named: "hotelImage")
        //            cell.roomPrice.text = String(room.number)
        //            cell.roomRating.text = String(room.rating) + " Stars"
        //            cell.roomType.text  = room.type
        //            
        //            
        //            do {
        //                try realm.write {
        //                    
        //                    realm.add(room)
        //                    
        //                    hotel?.rooms.append(room)
        //                    
        //                    realm.add(hotel!)
        //                }
        //            }  catch {
        //                print(error.localizedDescription)
        //            }
        //        }
        
        
        return cell
    }
}

//MARK: - UI Table View Delegate
extension RoomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.roomDetailsSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RoomDetailsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.roomDetails = roomLogic.rooms?[indexPath.row]
        }
    }
}
