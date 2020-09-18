//
//  Country.swift
//  RestCountries
//
//  Created by Kisacka on 18/09/2020.
//  Copyright © 2020 Kisacka. All rights reserved.
//

import Foundation

struct Country {
    
    let name: String?
    let capital: String? // Optional because for exmpl Antarctida don't have capital city
    let region: String?
    
    //initializer so we can take only those names from jason dictionary
    init(item: [String: Any]) {
        //Any because there can be integer etc.
        name = item["name"] as? String
        capital = item["capital"] as? String
        region = item["region"] as? String
        
    }
    
    static func getArray(from arrayOfItems: Any) -> [Country]? {
        //gives back array of countries
        
        guard let arrayOfCountryItems = arrayOfItems as? Array<[String: Any]> else {return nil}
        return arrayOfCountryItems.compactMap {Country(item: $0)} //starting from first
    }
    
}
