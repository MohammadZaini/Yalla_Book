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
    @IBOutlet weak var typePickerView: UIPickerView!
    @IBOutlet weak var pricePickerView: UIPickerView!
    @IBOutlet weak var bedPickerView: UIPickerView!
    
    @IBOutlet weak var noRoomsView: UIView!
    private var roomLogic = RoomLogic()
    private var sortAscending = true

    var selectedHotel: HotelData? {
        didSet {
            loadRooms()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerRoomCell()
        setupUI()
    }
    
    private func setupUI() {
        UIHelper.roundCorners(of: typePickerView, with: 20)
        UIHelper.roundCorners(of: pricePickerView, with: 20)
        UIHelper.roundCorners(of: bedPickerView, with: 20)
        
        typePickerView.backgroundColor = UIColor(hexString: K.BrandColor.primary)
        pricePickerView.backgroundColor = UIColor(hexString: K.BrandColor.primary)
        bedPickerView.backgroundColor = UIColor(hexString: K.BrandColor.primary)
        typePickerView.setValue(UIColor(hexString: K.BrandColor.secondry), forKeyPath: "textColor")
        pricePickerView.setValue(UIColor(hexString: K.BrandColor.secondry), forKeyPath: "textColor")
        bedPickerView.setValue(UIColor(hexString: K.BrandColor.secondry), forKeyPath: "textColor")
        noRoomsView.backgroundColor = UIColor(hexString: K.BrandColor.secondry)
        view.backgroundColor = UIColor(hexString: K.BrandColor.secondry)
        tableView.backgroundColor = UIColor(hexString: K.BrandColor.secondry)
    }
    
    private func loadRooms() {
        roomLogic.selectedHotel = selectedHotel
        roomLogic.loadRooms()
    }
    
    private func registerRoomCell() {
        tableView.register(UINib(nibName: K.roomCellNibName, bundle: nil), forCellReuseIdentifier: K.roomCellIdentfier)
    }
    
    @IBAction func typeButtonPressed(_ sender: UIButton) {
        typePickerView.isHidden = false
//        pricePickerView.isHidden = false
//        bedPickerView.isHidden = false
    }
    @IBAction func sortByPricePressed(_ sender: UIButton) {
        
        sortAscending = !sortAscending
        roomLogic.sortRoomsByPrice(sortAscending)
        tableView.reloadData()
    }
}

//MARK: - UI Table View Data Source
extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if roomLogic.rooms?.count == 0 {
            noRoomsView.isHidden = false
            tableView.backgroundView = noRoomsView
        } else {
            tableView.backgroundView = nil
            noRoomsView.isHidden = true
        }
        return roomLogic.rooms?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.roomCellIdentfier, for: indexPath) as! RoomTableViewCell
        
        
        if let room = roomLogic.rooms?[indexPath.row] {
            cell.roomImageView.image = UIImage(named: "hotelImage")
            cell.roomPrice.text = String(room.number)
            cell.roomRating.text = roomLogic.drawStars(numberOfStars: room.rating)
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

//MARK: - UI Picker View Data Source
extension RoomsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roomLogic.roomTypes.count
    }
}

//MARK: - UI Picker View Delegate
extension RoomsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roomLogic.roomTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typePickerView.isHidden = true
        
        roomLogic.filterRoomsBy(type: roomLogic.roomTypes[row])
        tableView.reloadData()
        
        
    }
    
    
}
