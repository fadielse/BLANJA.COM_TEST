//
//  SingleDataResponse.swift
//  Real Weather
//
//  Created by FADIELSE on 07.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

protocol ResponseDataConvertible {
    init?(rawData: Any)
}

struct SingleDataResponse<T: ResponseDataConvertible>: Response {
    let data: T?
    var code: String = ""
    var message: String = ""
    
    init?(json: Any) {
        if let json = json as? [String: Any] {
            if let code = json["Code"] as? String {
                self.code = code
            }
            
            if let message = json["Message"] as? String {
                self.message = message
            }
            
            self.data = T(rawData: json)
        } else {
            return nil
        }
    }
}
