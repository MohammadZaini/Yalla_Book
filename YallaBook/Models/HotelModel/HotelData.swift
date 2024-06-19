//
//  HotelsData.swift
//  YallaBook
//
//  Created by Moe on 23/05/2024.
//

import Foundation
import RealmSwift

class HotelData: Object {
    
    @Persisted(primaryKey: true) var hotelId: Int 
    @Persisted var name: String = ""
    @Persisted var location: String = ""
    @Persisted var rating: Int = 0
    @Persisted var image: String = ""
    @Persisted var rooms: List<RoomData>

    required override init() {
        super.init()
    }
    
    convenience init(name: String, location: String, rating: Int, image: String){
        self.init()
        
        self.hotelId = RealmHelper.incrementID(realmType: Self.self, property: "hotelId")
        self.name = name
        self.location = location
        self.rating = rating
        self.image = image
    }
}
