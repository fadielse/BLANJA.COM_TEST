//
//  WeatherDetailViewController.swift
//  Real Weather
//
//  Created by FADIELSE on 07.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

import UIKit

final class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var weatherBackgroundImage: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var unitTypeButton: UIButton!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dailyForecasts: WeatherDetail!
    var todayForecast: Forecast!
    var isCelciusUnit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getWeatherDetail()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutingSubviews()
    }
}

// MARK: - Layout
extension WeatherDetailViewController {
    func layoutingSubviews() {
        layoutingRefreshButton()
        layoutingUnitTypeButton()
    }
    
    func layoutingRefreshButton() {
        refreshButton.clipsToBounds = true
        refreshButton.layer.cornerRadius = refreshButton.frame.width / 2
        refreshButton.layer.borderWidth = 2.0
        refreshButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func layoutingUnitTypeButton() {
        unitTypeButton.clipsToBounds = true
        unitTypeButton.layer.cornerRadius = unitTypeButton.frame.width / 2
        unitTypeButton.layer.borderWidth = 2.0
        unitTypeButton.layer.borderColor = UIColor.lightGray.cgColor
    }
}

// MARK: - Setup
extension WeatherDetailViewController {
    func setupSubviews() {
        setupRefreshButton()
        setupUnitTypeButton()
        setupDateTimeLabel()
        setupWeatherLabel()
        setupTemperatureLabel()
        setupLocationLabel()
        setupCollectionView()
    }
    
    func setupWeatherBackground() {
        weatherBackgroundImage.image = Int(NSDate().timeIntervalSince1970) >= todayForecast.moon.epochRise
        ? UIImage(named: "\(todayForecast.night.icon)_background")
        : UIImage(named: "\(todayForecast.day.icon)_background")
    }
    
    func setupRefreshButton() {
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    }
    
    func setupUnitTypeButton() {
        unitTypeButton.setTitle(isCelciusUnit ? "°F" : "°C", for: .normal)
        unitTypeButton.addTarget(self, action: #selector(temperatureButtonTapped), for: .touchUpInside)
    }
    
    func setupDateTimeLabel() {
        dateTimeLabel.text = convertEpochToDate(withTimeStamp: todayForecast.epochDate, AndFormat: "E, dd MMM yyyy HH:mm")
    }
    
    func setupWeatherLabel() {
        weatherLabel.text = todayForecast.day.shortPhrase
    }
    
    func setupTemperatureLabel() {
        temperatureLabel.text = !isCelciusUnit
            ? "\(todayForecast.temperature.temperatureMin.value)°\(todayForecast.temperature.temperatureMin.unit)"
            : "\(convertToCelsius(fahrenheit: todayForecast.temperature.temperatureMin.value))°C"
    }
    
    func setupLocationLabel() {
        
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Action
extension WeatherDetailViewController {
    func getWeatherDetail() {
        refreshButton.isEnabled = false
        
        WeatherDetailRequest(locationID: 208971, detail: true, metric: false).send { result in
            self.refreshButton.isEnabled = true
            
            switch result {
            case .success(let response):
                if let dailyForecasts = response.data {
                    if dailyForecasts.forecasts.count > 0 {
                        self.dailyForecasts = dailyForecasts
                        self.todayForecast = dailyForecasts.forecasts[1]
                        
                        self.dailyForecasts.forecasts.remove(at: 1)
                        
                        if self.todayForecast != nil {
                            self.setupSubviews()
                            self.setupWeatherBackground()
                        }
                    }
                } else {
                    print("Error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func backButtonTapped() {
        
    }
    
    @objc func temperatureButtonTapped() {
        temperatureLabel.text = isCelciusUnit
            ? "\(todayForecast.temperature.temperatureMin.value)°\(todayForecast.temperature.temperatureMin.unit)"
            : "\(convertToCelsius(fahrenheit: todayForecast.temperature.temperatureMin.value))°C"
        
        isCelciusUnit = !isCelciusUnit
        
        setupUnitTypeButton()
        collectionView.reloadData()
    }
    
    @objc func refreshButtonTapped() {
        getWeatherDetail()
    }
}

// MARK: - CollectionView Delegate
extension WeatherDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyForecasts.forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width / 3.5)
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCardCollectionViewCell {
            cell.configureCell(withData: dailyForecasts.forecasts[indexPath.row], andIndexpath: indexPath, andIsCelcius: isCelciusUnit)
            
            return cell
        } else {
            return WeatherCardCollectionViewCell()
        }
    }
}










