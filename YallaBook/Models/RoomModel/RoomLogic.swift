//
//  RoomLogic.swift
//  YallaBook
//
//  Created by Moe on 13/06/2024.
//

import Foundation
import RealmSwift

class RoomLogic {
    
    let realm = try! Realm()
    var rooms: Results<RoomData>?
    var selectedHotel: HotelData?
    var roomTypes = ["Single", "Double", "Twin","Triple","Quad","Suite", "Deluxe", "All"]
    var bedsNumber = [1,2,3,4]
    
    func loadRooms() {
        rooms = selectedHotel?.rooms.sorted(byKeyPath: "id", ascending: true)
    }
    
    func filterRoomsBy(type: String) {
        
        guard type != "All" else {
            loadRooms()
            return
        }
        
        rooms = selectedHotel?.rooms.filter("type == %@", type)
    }
    
    func filterRoomsBy(numberOfBeds: Int) {
        
        guard numberOfBeds >= 1 else { return }
        rooms = selectedHotel?.rooms.filter("numberOfBeds == %@", numberOfBeds)
    }
    
    func drawStars(numberOfStars: Int) -> String {
        var stars = ""
        for _ in 1 ... numberOfStars {
            stars += "★"
        }
        
        return stars
    }
    
    func sortRoomsByPrice(_ ascending: Bool) {
        rooms = rooms?.sorted(byKeyPath: "price", ascending: ascending)
    }
}
