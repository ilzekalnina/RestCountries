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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .white //by default bgr is black
        tableView.dataSource = self
        tableView.allowsSelectionDuringEditing = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        
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
    }
    
    @objc private func infoItemTapped(){
        print("Info tapped")
        basicAlert(title: "Info", message: "Hi! There!")
        
    }
    
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell  = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath)
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
        
        cell.textLabel?.text = "List"
        cell.detailTextLabel?.text = "Name"
        cell.selectionStyle = .none
        return cell
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
}

