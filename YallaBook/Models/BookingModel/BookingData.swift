//
//  BookingsData.swift
//  YallaBook
//
//  Created by Moe on 11/06/2024.
//

import Foundation
import RealmSwift

class BookingData: Object {
    
    @Persisted(primaryKey: true) var bookingId: Int = 0
    @Persisted var hotelId: Int = 0
    @Persisted var roomId: Int = 0
    @Persisted var checkinDate: Date = Date()
    @Persisted var checkoutDate: Date = Date()
    @Persisted var guestName: String = ""
    @Persisted var guestContact: String = ""
    @Persisted(originProperty: "bookings") var room: LinkingObjects<RoomData>
    
    required override init() {
        super.init()
    }
    
    convenience init(hotelId: Int, roomId: Int, checkinDate: Date, checkoutDate: Date, guestName: String, guestContact: String) {
        self.init()
        self.bookingId = RealmHelper.incrementID(realmType: Self.self, property: "bookingId")
        self.hotelId = hotelId
        self.roomId = roomId
        self.checkinDate = checkinDate
        self.checkoutDate = checkoutDate
        self.guestName = guestName
        self.guestContact = guestContact
    }
}
