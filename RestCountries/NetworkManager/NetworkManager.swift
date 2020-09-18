//
//  NetworkManager.swift
//  RestCountries
//
//  Created by Kisacka on 18/09/2020.
//  Copyright © 2020 Kisacka. All rights reserved.
//

import Foundation
import Alamofire

class NetWorkManager {
    
    static private let jsonUrl = "https://restcountries.eu/rest/v2/all"
    
    static func fetchData(completion: @escaping ([Country]) -> ()) {
    
        AF.request(jsonUrl).validate().responseJSON { jsonData in
            switch jsonData.result{
            case .success(let value):
                let countries = Country.getArray(from: value)
                completion(countries ?? [])
            case .failure(let error):
                print("Error: ", error)
            }
        }
    }
    
}
