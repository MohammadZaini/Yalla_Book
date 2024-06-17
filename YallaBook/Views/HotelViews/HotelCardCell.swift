//
//  HotelCardCell.swift
//  YallaBook
//
//  Created by Moe on 22/05/2024.
//

import UIKit

class HotelCardCell: UICollectionViewCell {
    
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var hotelStarsLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UIHelper.roundCorners(of: hotelImageView, with: 20)
        UIHelper.roundCorners(of: view, with: 20)
    }
}
