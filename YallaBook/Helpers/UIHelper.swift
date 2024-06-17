//
//  UIHelper.swift
//  YallaBook
//
//  Created by Moe on 09/06/2024.
//

import UIKit

class UIHelper {
    
    static func roundCorners(of view: UIView, with points: CGFloat)  {
        view.layer.cornerRadius = points
        view.layer.masksToBounds = true
    }
}
