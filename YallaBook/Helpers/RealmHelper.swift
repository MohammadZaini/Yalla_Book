//
//  RealmHelper.swift
//  YallaBook
//
//  Created by Moe on 12/06/2024.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static func incrementID(realmType: Object.Type, property: String) -> Int {
        let realm = try! Realm()
        return (realm.objects(realmType).max(ofProperty: property) as Int? ?? 0) + 1
    }
}
