//
//  RoomData.swift
//  YallaBook
//
//  Created by Moe on 23/05/2024.
//

import RealmSwift

class RoomData: Object {
    @Persisted(primaryKey: true) var id: Int 
    @Persisted var hotelId: Int
    @Persisted var type: String = ""
    @Persisted var price: Float = 0.0
    @Persisted var image: String = ""
    @Persisted var discountPrice: Float?
    @Persisted var roomDescription: String = ""
    @Persisted var numberOfBeds: Int = 1
    @Persisted var rating: Int = 0
    @Persisted var number: Int = 0
    @Persisted var bookings = List<BookingData>()
    @Persisted var hotel = LinkingObjects(fromType: HotelData.self, property: "rooms")
    
    required override init() {
        super.init()
    }
    
    convenience init(hotelId: Int, type: String, price: Float, image: String, discountPrice: Float? = nil, roomDescription: String, numberOfBeds: Int, rating: Int, number: Int) {
        self.init()
        self.hotelId = hotelId
        self.id = RealmHelper.incrementID(realmType: Self.self, property: "id") // Set the primary key
        self.type = type
        self.price = price
        self.image = image
        self.discountPrice = discountPrice
        self.roomDescription = roomDescription
        self.numberOfBeds = numberOfBeds
        self.rating = rating
        self.number = number
    }
}
