//
//  HotelLogic.swift
//  YallaBook
//
//  Created by Moe on 23/05/2024.
//

import Foundation
import RealmSwift

struct HotelLogic {
    
    private let realm = try! Realm()
    
    var hotels: Results<HotelData>?
    
    private mutating func getAllHotels() {
        hotels = realm.objects(HotelData.self)
    }
    
    init() {
        getAllHotels()
    }    
}
