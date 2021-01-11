//
//  ConverterItem.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 05/01/21.
//

import UIKit

struct ConverterItem: Decodable {
    /**
    *  Attributes here
    */
    var currencyName : String = ""
    var country : String = ""
    var code : String = ""
    var symbol : String = ""
    var amount : String = ""
    var flag : String = ""
    var convertedAmount : String = ""
    var isFreshLoad : Bool = false

    init(code: String, amount: String) {
        self.code = code
        self.amount = amount
    }
}
