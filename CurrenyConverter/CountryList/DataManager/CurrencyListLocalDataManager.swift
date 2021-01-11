//
//  CurrencyListLocalDataManager.swift
//  CurrenyConverter
//
//  Created by Nuzhat Zari on 10/01/21.
//

import UIKit

class CurrencyListLocalDataManager: CurrencyListLocalDataManagerProtocol {
    init() {}
    
    func loadCurrencyListArrayFromBundle() -> NSArray? {
        let mainBundle = Bundle.main
        let path = mainBundle.path(forResource: "CountryData", ofType: "plist")
        return NSArray(contentsOfFile: path!)
    }
}
