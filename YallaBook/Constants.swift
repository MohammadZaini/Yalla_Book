//
//  Constants.swift
//  YallaBook
//
//  Created by Moe on 23/05/2024.
//

struct K {
    
    static let hotelCardCellIdentfier = "hotelCard"
    static let hotelCardNibName = "HotelCardCell"
    static let roomCellIdentfier = "roomCell"
    static let roomDetailsSegue = "goToRoomDetails"
    static let goToRoomsSegue = "goToRooms"
    static let roomCellNibName = "RoomTableViewCell"
    static let roomPhotoCellNibName = "RoomCollectionViewCell"
    static let roomPhotoIdentifer = "roomImageCell"
    
    struct BrandColor {
        static let primary = "#AD7F51"
        static let secondry = "#F8F4E1"
    }
    
    struct Alert {
        static let successTitle = "Success"
        static let bookedSuccessfullyMessage = "The room has been booked successfully!"
        static let failureTitle = "Failure"
        static let bookingFailedMessage = "The room booking failed"
        static let alreadyBookedMessage = "This room is already booked on the selected date"
    }
}
