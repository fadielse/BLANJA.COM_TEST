//
//  Locations.swift
//  Real Weather
//
//  Created by FADIELSE on 08.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

import Foundation

struct Area {
    let ID: String
    let localizedName: String
}

struct Location {
    let key: String
    let localizedName: String
    let administrativeArea: Area
}

final class Locations: NSObject {
    var locations: [Location] = []
    
    init?(dictionary: [[String: Any]]) {
        for location in dictionary {
            var tmpKey: String = ""
            var tmpLocalizedName: String = ""
            var tmpAreaID:String = ""
            var tmpAreaLoalizedName: String = ""
            
            if let key = location["Key"] as? String {
                tmpKey = key
            }
            
            if let localizedName = location["LocalizedName"] as? String {
                tmpLocalizedName = localizedName
            }
            
            if let administrativeArea = location["AdministrativeArea"] as? [String: Any] {
                if let ID = administrativeArea["ID"] as? String {
                    tmpAreaID = ID
                }
                
                if let localizedName = administrativeArea["LocalizedName"] as? String {
                    tmpAreaLoalizedName = localizedName
                }
            }
            
            let tmpLocation: Location = Location(key: tmpKey,
                                                 localizedName: tmpLocalizedName,
                                                 administrativeArea: Area(ID: tmpAreaID,
                                                                          localizedName: tmpAreaLoalizedName))
            
            self.locations.append(tmpLocation)
        }
    }
}

extension Locations: ResponseDataConvertible {
    convenience init?(rawData: Any) {
        if let dictionary = rawData as? [[String: Any]] {
            self.init(dictionary: dictionary)
        } else {
            return nil
        }
    }
}
