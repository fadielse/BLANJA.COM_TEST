//
//  WeatherDetail.swift
//  Real Weather
//
//  Created by FADIELSE on 07.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

import Foundation

struct IconPhrase {
    let icon: Int
    let iconPhrase: String
    let shortPhrase: String
    let longPhrase: String
}

struct TemperatureValue {
    let value: Int
    let unit: String
}

struct Temperature {
    let temperatureMin: TemperatureValue
    let temperatureMax: TemperatureValue
}

struct Rise {
    let epochRise: Int
    let epochSet: Int
}

struct Forecast {
    let epochDate: Int
    let sun: Rise
    let moon: Rise
    let temperature: Temperature
    let day: IconPhrase
    let night: IconPhrase
}

final class WeatherDetail: NSObject {
    var forecasts: [Forecast] = []
    
    init?(dictionary: [String: Any]) {
        if let dailyForecasts = dictionary["DailyForecasts"] as? [[String: Any]] {
            for dailyForecast in dailyForecasts {
                var tmpEpochDate: Int = 0
                var tmpSun: Rise = Rise(epochRise: 0, epochSet: 0)
                var tmpMoon: Rise = Rise(epochRise: 0, epochSet: 0)
                
                var tmpMinimum: TemperatureValue = TemperatureValue(value: 0, unit: "")
                var tmpMaximum: TemperatureValue = TemperatureValue(value: 0, unit: "")
                
                var tmpTemperature: Temperature = Temperature(temperatureMin: tmpMinimum, temperatureMax: tmpMaximum)
                var tmpDay: IconPhrase = IconPhrase(icon: 0, iconPhrase: "", shortPhrase: "", longPhrase: "")
                var tmpNight: IconPhrase = IconPhrase(icon: 0, iconPhrase: "", shortPhrase: "", longPhrase: "")
                
                if let epochDate = dailyForecast["EpochDate"] as? Int {
                    tmpEpochDate = epochDate
                }
                
                if let sun = dailyForecast["Sun"] as? [String: Any] {
                    var tmpEpochRise: Int = 0
                    var tmpEpochSet: Int = 0
                    
                    if let epochRise = sun["EpochRise"] as? Int {
                        tmpEpochRise = epochRise
                    }
                    
                    if let epochSet = sun["EpochSet"] as? Int {
                        tmpEpochSet = epochSet
                    }
                    
                    tmpSun = Rise(epochRise: tmpEpochRise, epochSet: tmpEpochSet)
                }
                
                if let moon = dailyForecast["Moon"] as? [String: Any] {
                    var tmpEpochRise: Int = 0
                    var tmpEpochSet: Int = 0
                    
                    if let epochRise = moon["EpochRise"] as? Int {
                        tmpEpochRise = epochRise
                    }
                    
                    if let epochSet = moon["EpochSet"] as? Int {
                        tmpEpochSet = epochSet
                    }
                    
                    tmpMoon = Rise(epochRise: tmpEpochRise, epochSet: tmpEpochSet)
                }
                
                if let temperature = dailyForecast["RealFeelTemperature"] as? [String: Any] {
                    if let minimum = temperature["Minimum"] as? [String: Any] {
                        var tmpValue: Int = 0
                        var tmpUnit: String = ""
                        
                        if let value = minimum["Value"] as? Int {
                            tmpValue = value
                        }
                        
                        if let unit = minimum["Unit"] as? String {
                            tmpUnit = unit
                        }
                        
                        tmpMinimum = TemperatureValue(value: tmpValue, unit: tmpUnit)
                    }
                    
                    if let maximum = temperature["Maximum"] as? [String: Any] {
                        var tmpValue: Int = 0
                        var tmpUnit: String = ""
                        
                        if let value = maximum["Value"] as? Int {
                            tmpValue = value
                        }
                        
                        if let unit = maximum["Unit"] as? String {
                            tmpUnit = unit
                        }
                        
                        tmpMaximum = TemperatureValue(value: tmpValue, unit: tmpUnit)
                    }
                    
                    tmpTemperature = Temperature(temperatureMin: tmpMinimum, temperatureMax: tmpMaximum)
                } else {
                    return nil
                }
                
                if let day = dailyForecast["Day"] as? [String: Any] {
                    var tmpIcon: Int = 0
                    var tmpIconPhrase: String = ""
                    var tmpShortPhrase: String = ""
                    var tmpLongPhrase: String = ""
                    
                    if let icon = day["Icon"] as? Int {
                        tmpIcon = icon
                    }
                    
                    if let iconPhrase = day["IconPhrase"] as? String {
                        tmpIconPhrase = iconPhrase
                    }
                    
                    if let shortPhrase = day["ShortPhrase"] as? String {
                        tmpShortPhrase = shortPhrase
                    }
                    
                    if let longPhrase = day["LongPhrase"] as? String {
                        tmpLongPhrase = longPhrase
                    }
                    
                    tmpDay = IconPhrase(icon: tmpIcon, iconPhrase: tmpIconPhrase, shortPhrase: tmpShortPhrase, longPhrase: tmpLongPhrase)
                }
                
                if let night = dailyForecast["Night"] as? [String: Any] {
                    var tmpIcon: Int = 0
                    var tmpIconPhrase: String = ""
                    var tmpShortPhrase: String = ""
                    var tmpLongPhrase: String = ""
                    
                    if let icon = night["Icon"] as? Int {
                        tmpIcon = icon
                    }
                    
                    if let iconPhrase = night["IconPhrase"] as? String {
                        tmpIconPhrase = iconPhrase
                    }
                    
                    if let shortPhrase = night["ShortPhrase"] as? String {
                        tmpShortPhrase = shortPhrase
                    }
                    
                    if let longPhrase = night["LongPhrase"] as? String {
                        tmpLongPhrase = longPhrase
                    }
                    
                    tmpNight = IconPhrase(icon: tmpIcon, iconPhrase: tmpIconPhrase, shortPhrase: tmpShortPhrase, longPhrase: tmpLongPhrase)
                }
                
                self.forecasts.append(Forecast(epochDate: tmpEpochDate,
                                               sun: tmpSun,
                                               moon: tmpMoon,
                                               temperature: tmpTemperature,
                                               day: tmpDay,
                                               night: tmpNight))
            }
        }
    }
}

extension WeatherDetail: ResponseDataConvertible {
    convenience init?(rawData: Any) {
        if let dictionary = rawData as? [String: Any] {
            self.init(dictionary: dictionary)
        } else {
            return nil
        }
    }
}
