//
//  WeatherDetailRequest.swift
//  Real Weather
//
//  Created by FADIELSE on 07.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

import Foundation

struct WeatherDetailRequest {
    let locationID: Int
    let detail: Bool
    let metric: Bool
}

extension WeatherDetailRequest: Request {
    var baseURL: URL {
        return URL(fileURLWithPath: kAPIURL)
    }
    
    var path: String {
        return "/daily/5day/\(locationID)"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        return [
            "apikey": kAPIKey,
            "language": "en-us",
            "details": detail ? "true" : "false",
            "metric": metric ? "true" : "false"
        ]
    }
    
    
    typealias ResponseType = SingleDataResponse<WeatherDetail>
}
