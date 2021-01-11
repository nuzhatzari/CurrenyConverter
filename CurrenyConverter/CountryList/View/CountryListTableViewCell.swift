//
//  CountryListTableViewCell.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 07/01/21.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCurrencyName: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
