//
//  BookAnAppointmentVC.swift
//  YallaBook
//
//  Created by Moe on 05/06/2024.
//

import UIKit

protocol BookingRoomDelegate {
    func updateUIOnDismiss()
}

class BookAnAppointmentViewController: UIViewController {
    
    @IBOutlet weak var checkinLabel: UILabel!
    @IBOutlet weak var checkoutLabel: UILabel!
    @IBOutlet weak var openDatePickerLabel: UILabel!
    @IBOutlet weak var checkinDatePicker: UIDatePicker!
    @IBOutlet weak var checkoutDatePicker: UIDatePicker!
    @IBOutlet weak var bookRoomButton: UIButton!
    
    var roomDetails: RoomData?
    private var bookingLogic: BookingLogic?
    var delegate: BookingRoomDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBookingLogic()
        resetUI()
        setMinDateForDatePicker()
        applyBrandColors()
    }
    
    private func initializeBookingLogic() {
        if let room = roomDetails {
            bookingLogic = BookingLogic(room: room)
            bookingLogic?.delegate = self
        }
    }
    
    private func applyBrandColors() {
        checkinDatePicker.tintColor = UIColor(hexString: K.BrandColor.primary)
        checkinLabel.textColor = UIColor(hexString: K.BrandColor.primary)
        checkoutDatePicker.tintColor = UIColor(hexString: K.BrandColor.primary)
        checkoutLabel.textColor = UIColor(hexString: K.BrandColor.primary)
        bookRoomButton.tintColor = UIColor(hexString: K.BrandColor.primary)
    }
    
    private func toggleBookRoomButton() {
        bookRoomButton.isEnabled = checkinLabel.text?.count != 0 && checkoutLabel.text?.count != 0
    }
    
    private func resetUI() {
        view.backgroundColor = UIColor(hexString: K.BrandColor.secondry)
        bookRoomButton.backgroundColor = UIColor(hexString: K.BrandColor.primary)
        bookRoomButton.isEnabled = false
        checkinLabel.text = ""
        checkoutLabel.text = ""
    }
        
    private func setMinDateForDatePicker() {
        
        let today = Date()
        checkinDatePicker.minimumDate = today
        checkoutDatePicker.minimumDate = DateHelper.getNextDayOf(date: checkinDatePicker.date)
    }
    
    @IBAction func checkinDatePickerValueChanged(_ sender: UIDatePicker) {
        checkinLabel.text = DateHelper.formattedDateString(sender)
        toggleBookRoomButton()
        setMinDateForDatePicker()
    }
    
    @IBAction func checkoutDatePickerValueChanged(_ sender: UIDatePicker) {
        checkoutLabel.text = DateHelper.formattedDateString(sender)
        toggleBookRoomButton()
    }
    
    @IBAction func bookRoomButtonPressed(_ sender: UIButton) {
        
        let isBooked = bookingLogic?.isRoomBooked(checkinString: checkinLabel.text!, checkoutString: checkoutLabel.text!) ?? true
        
        if(isBooked) {
            AlertHelper.showFailureAlert(on: self, alertTitle: K.Alert.failureTitle, alertMessage: K.Alert.alreadyBookedMessage)
            
            return
        }
        
        if let checkinDate = DateHelper.formattedDate(stringDate: checkinLabel.text!),
           let checkoutDate =  DateHelper.formattedDate(stringDate: checkoutLabel.text!),
           let room = roomDetails {
            
            bookingLogic?.createBooking(hotelId: room.hotelId, roomId: room.id, checkinDate: checkinDate, checkoutDate: checkoutDate, guestName: "Unknown", guestContact: "Unknown")
        }
    }
}

//MARK: - Booking Logic Delegate
extension BookAnAppointmentViewController: BookingLogicDelegate {
    
    func showAcknowledgmentAlert() {
        AlertHelper.showAcknowledgmentAlert(on: self, alertTitle: K.Alert.successTitle, alertMessage: K.Alert.bookedSuccessfullyMessage, completion: {
            
            self.dismiss(animated: true) {
                self.delegate?.updateUIOnDismiss()
            }
        })
    }
    
    func showFailureAlert() {
        AlertHelper.showFailureAlert(on: self, alertTitle: K.Alert.failureTitle, alertMessage: K.Alert.bookingFailedMessage)
    }
}
