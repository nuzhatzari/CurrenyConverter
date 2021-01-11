//
//  ConverterItemTableViewCell.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 05/01/21.
//

import UIKit

class ConverterItemTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var currencyCode: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
