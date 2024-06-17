//
//  BookingLogic.swift
//  YallaBook
//
//  Created by Moe on 12/06/2024.
//

import Foundation
import RealmSwift

protocol BookingLogicDelegate {
    
    func showAcknowledgmentAlert()
    func showFailureAlert()
}

struct BookingLogic {
    
    var room: RoomData
    private var booking: BookingData?
    let realm = try! Realm()
    
    var delegate: BookingLogicDelegate?
    
    init(room: RoomData, booking: BookingData? = nil) {
        self.room = room
        self.booking = booking
    }
    
    func isRoomBooked(checkinString: String, checkoutString: String) -> Bool {
        // Ensure there are bookings to check
        guard !room.bookings.isEmpty else { return false }
        
        // Ensure check-in and check-out dates are valid
        guard let selectedCheckinDate = DateHelper.formattedDate(stringDate: checkinString),
              let selectedCheckoutDate = DateHelper.formattedDate(stringDate: checkoutString) else {
            return false
        }
        
        // Check for overlapping bookings
        for roomBooking in room.bookings {
            let isCheckinOverlap = DateHelper.isDateOverlapping(targetDate: selectedCheckinDate, startDate: roomBooking.checkinDate, endDate: roomBooking.checkoutDate)
            let isCheckoutOverlap = DateHelper.isDateOverlapping(targetDate: selectedCheckoutDate, startDate: roomBooking.checkinDate, endDate: roomBooking.checkoutDate)
            
            if isCheckinOverlap || isCheckoutOverlap {
                return true
            }
        }
        
        return false
    }
    
    mutating func createBooking(hotelId: Int, roomId: Int, checkinDate: Date, checkoutDate: Date, guestName: String, guestContact: String) {
        
        booking = BookingData(hotelId: hotelId, roomId: roomId, checkinDate: checkinDate, checkoutDate: checkoutDate, guestName: guestName, guestContact: guestContact)
        
        saveBooking()
    }
    
    private func saveBooking() {
        
        guard let booking = booking else { return }
        
        do {
            try realm.write {
                room.bookings.append(booking)
            }
            delegate?.showAcknowledgmentAlert()
            
        } catch {
            delegate?.showFailureAlert()
        }
    }
}
