//
//  RoomTableViewCell.swift
//  YallaBook
//
//  Created by Moe on 22/05/2024.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var roomType: UILabel!
    @IBOutlet weak var roomPrice: UILabel!
    @IBOutlet weak var roomRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        UIHelper.roundCorners(of: roomImageView, with: 20)
        contentView.superview?.backgroundColor = UIColor(hexString: K.BrandColor.secondry)
    }
}
