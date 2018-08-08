//
//  SearchLocationViewController.swift
//  Real Weather
//
//  Created by FADIELSE on 08.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

import UIKit

final class SearchLocationViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var locations: [Location] = []
    
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
extension SearchLocationViewController {
    func layoutingSubviews() {
        layoutingSearchButton()
    }
    
    func layoutingSearchButton() {
        searchButton.clipsToBounds = true
        searchButton.layer.cornerRadius = 6.0
    }
}

// MARK: - Setup
extension SearchLocationViewController {
    func setupSubviews() {
        setupSearchButton()
        setupTableView()
    }
    
    func setupSearchTextField() {
        searchTextField.delegate = self
    }
    
    func setupSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

// MARK: - Action
extension SearchLocationViewController {
    @objc func searchButtonTapped() {
        searchTextField.resignFirstResponder()
        getLocations()
    }
    
    func getLocations() {
        if searchTextField.text == "" {
            return
        }
        
        LocationsRequest(keyword: searchTextField.text!).send { result in
            switch result {
            case .success(let response):
                if let locationList = response.data {
                    self.locations.removeAll()
                    
                    for location in locationList.locations {
                        self.locations.append(location)
                    }
                    
                    self.tableView.reloadData()
                } else {
                    print("Error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func goToWeatherDetail(withLocation location: Location) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "weatherVC") as! WeatherDetailViewController
        vc.location = location
        
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - TextField Delegate
extension SearchLocationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        
        getLocations()
        
        return true
    }
}

// MARK: - TableView Delegate
extension SearchLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.backgroundColor = indexPath.row % 2 == 0 ? .white : UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        cell.textLabel!.text = "\(locations[indexPath.row].localizedName), \(locations[indexPath.row].administrativeArea.localizedName)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToWeatherDetail(withLocation: locations[indexPath.row])
    }
}
