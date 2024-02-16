//
//  CatCell.swift
//  CatsApp
//
//  Created by Resat Pekgozlu on 16/02/2024.
//

import UIKit

class CatCell: UITableViewCell {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier = "CatCell"
    
    static let height = 120.00
    
    static func nib() -> UINib {
        return UINib(nibName: "CatCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
