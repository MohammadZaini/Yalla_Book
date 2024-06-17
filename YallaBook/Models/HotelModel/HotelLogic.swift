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

//    func drawStars(numberOfStars: Int) -> String {
//        
//        var starsString: String = ""
//        for _ in 1...numberOfStars {
//            
//            starsString += "\(UIImage(systemName: "star.fill") ?? UIImage())"
//        }
//        print(starsString)
//        return starsString
//    }
    
}
