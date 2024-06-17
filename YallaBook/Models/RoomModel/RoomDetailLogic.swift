//
//  RoomLogic.swift
//  YallaBook
//
//  Created by Moe on 23/05/2024.
//

import Foundation
import UIKit

struct RoomDetailLogic {

    var photos = [UIImage(named: "room1"),UIImage(named: "room2"),UIImage(named: "room3"),UIImage(named: "room4"),UIImage(named: "room5")]
    
    
    private(set) var currentPhotoCellIndex = 0
    
    internal mutating func getNextPhotoIndex() -> Int {
        if currentPhotoCellIndex < photos.count - 1 {
            currentPhotoCellIndex += 1
        } else {
           currentPhotoCellIndex = 0
        }
        
        return currentPhotoCellIndex
    }
}
