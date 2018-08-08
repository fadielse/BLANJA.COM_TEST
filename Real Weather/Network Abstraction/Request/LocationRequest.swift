//
//  LocationRequest.swift
//  Real Weather
//
//  Created by FADIELSE on 08.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

import Foundation

struct LocationsRequest {
    let keyword: String
}

extension LocationsRequest: Request {
    var baseURL: URL {
        return URL(fileURLWithPath: kAPIURL)
    }
    
    var path: String {
        return "/locations/v1/cities/autocomplete"
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
            "q": keyword,
        ]
    }
    
    typealias ResponseType = ListDataResponse<Locations>
}
