//
//  WeatherDetailViewController.swift
//  Real Weather
//
//  Created by FADIELSE on 07.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var weatherBackgroundImage: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var unitTypeButton: UIButton!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
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
        
    }
}

// MARK: - Action
extension WeatherDetailViewController {
    @objc func backButtonTapped() {
        
    }
    
    @objc func temperatureButtonTapped() {
        
    }
}
