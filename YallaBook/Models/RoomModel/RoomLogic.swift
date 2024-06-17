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
    var rooms: List<RoomData>?
    var selectedHotel: HotelData?
    
//    var rooms = [RoomData(hotelId: 1, type: "Suitee", price: 199, image: "", roomDescription: "A spacious room perfect for couples or two individuals. The room includes a double bed (or two single beds upon request), a sitting area, a flat-screen TV, and an en-suite bathroom with a bathtub or shower. Great for weekend getaways or extended stays", numberOfBeds: 3, rating: 4, number: 189),
//                 
//                 RoomData(hotelId: 2, type: "Delux", price: 170, image: "", roomDescription: "A cozy and comfortable room designed for solo travelers. The room features a single bed, a work desk, a flat-screen TV, and an en-suite bathroom with a shower. Ideal for business travelers or short stays.",  numberOfBeds: 2, rating:  2, number: 89),
//                 
//                 RoomData(hotelId: 3, type: "Single", price: 70, image: "", roomDescription: "A versatile room with two single beds, ideal for friends or colleagues traveling together. The room offers a comfortable workspace, a flat-screen TV, and an en-suite bathroom with modern fixtures.", numberOfBeds: 2, rating: 1, number: 142),
//                 
//                 
//                 RoomData(hotelId: 4, type: "Double", price: 119, image: "", roomDescription: "Designed to accommodate three guests, this room features three single beds (or one double bed and one single bed). It includes a spacious layout with a seating area, a flat-screen TV, and an en-suite bathroom. Perfect for small families or groups.", numberOfBeds: 2, rating: 4, number: 204),
//                 
//                 
//                 RoomData(hotelId: 5, type: "King Room", price: 250, image: "", roomDescription: "A large room designed for families, featuring one double bed and additional beds or sofa beds for children. The room includes a spacious layout, a seating area, and an en-suite bathroom with child-friendly amenities", numberOfBeds: 3, rating: 5, number: 121)
//                 
//    ]
    
    func loadRooms() {
        rooms = selectedHotel?.rooms
    }
    
}
