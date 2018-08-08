//
//  WeatherCardCollectionViewCell.swift
//  Real Weather
//
//  Created by FADIELSE on 07.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

import UIKit

class WeatherCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var forecast: Forecast!
    var indexPath: IndexPath!
    var isCelciusUnit: Bool = false
    
    func configureCell(withData data: Forecast, andIndexpath indexpath: IndexPath, andIsCelcius isCelciusUnit: Bool) {
        self.forecast = data
        self.indexPath = indexpath
        self.isCelciusUnit = isCelciusUnit
        
        layoutingSubviews()
        setupSubviews()
    }
}

// MARK: - Layout
extension WeatherCardCollectionViewCell {
    func layoutingSubviews() {
        layoutingContentView()
    }
    
    func layoutingContentView() {
        let redIntensity: CGFloat = CGFloat(243 + (indexPath.row * 13))
        let greenIntensity: CGFloat = CGFloat(124 + (indexPath.row * 13))
        let blueIntensity: CGFloat = CGFloat(57 + (indexPath.row * 13))
        
        self.backgroundColor = UIColor(red: redIntensity/255.0, green: greenIntensity/255.0, blue: blueIntensity/255.0, alpha: 1.0)
    }
}

// MARK: - Setup
extension WeatherCardCollectionViewCell {
    func setupSubviews() {
        setupDayLabel()
        setupWeatherImage()
        setuptemperatureLabel()
    }
    
    func setupDayLabel() {
        dayLabel.text = convertEpochToDate(withTimeStamp: forecast.epochDate, AndFormat: "EEEE")
    }
    
    func setupWeatherImage() {
        weatherImage.image = UIImage(named: "\(forecast.day.icon)_icon")
    }
    
    func setuptemperatureLabel() {
        temperatureLabel.text = !isCelciusUnit
            ?"\(forecast.temperature.temperatureMin.value)°\(forecast.temperature.temperatureMin.unit)/\(forecast.temperature.temperatureMax.value)°\(forecast.temperature.temperatureMin.unit)"
            :"\(convertToCelsius(fahrenheit: forecast.temperature.temperatureMin.value))°C/\(forecast.temperature.temperatureMax.value)°C"
    }
}
