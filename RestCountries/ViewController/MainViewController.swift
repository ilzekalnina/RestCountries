//
//  ViewController.swift
//  RestCountries
//
//  Created by Kisacka on 18/09/2020.
//  Copyright © 2020 Kisacka. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    private let cellID = "cell"
    
    private var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .white //by default bgr is black
        tableView.dataSource = self
        tableView.allowsSelectionDuringEditing = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        NetWorkManager.fetchData { countriesList in
            self.countries = countriesList
            self.tableView.reloadData()
        }
        
        
    }
    
    private func setupNavigationBar() {
        //at the beginning was just title, works also
        //title = "Countries list"
        navigationItem.title = "Countries list"
        
        //If there is lower version, the image won't work
        if #available(iOS 13.0, *) {
            let titleImage = UIImage(systemName: "mappin.and.ellipse")
            let imageView = UIImageView(image: titleImage)
            self.navigationItem.titleView = imageView
        }
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black
        ]
        
        //image on top will be black
        navigationController?.navigationBar.tintColor = .black
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoItemTapped))
        
        
        
    }
    
    @objc private func longPressed(sender: UILongPressGestureRecognizer) {
        print("Long Pressed tapped ")
        //to get indexPath.row, because we have only sender in func params.
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint){
                basicActionSheet(title: countries[indexPath.row].name, message: countries[indexPath.row].capital)
            }
        }
       
    }
    
    @objc private func infoItemTapped(){
        print("Info tapped")
        basicAlert(title: "Info", message: "Long press to open an action sheet, single tap on cell to open an alert.")
        
    }
    
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell  = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath)
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
        
        let country = countries[indexPath.row]
        
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.capital
        
        if let region = country.region {
            cell.detailTextLabel?.text! += " from region: \(region)"
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        basicAlert(title: countries[indexPath.row].region, message: "Capital of \(countries[indexPath.row].name ?? "") is \(countries[indexPath.row].capital ?? "").") // ?? "" is needed if there is nothing in the counntries name, otherwise will be error
    }
   
    //animation
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.5) {
            cell.transform = CGAffineTransform.identity
        }
    }
}

extension MainViewController {
    func basicAlert(title: String?, message: String?){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func basicActionSheet(title: String?, message: String?){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
}

