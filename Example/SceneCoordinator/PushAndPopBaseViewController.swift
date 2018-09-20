//
//  PushAndPopBaseViewController.swift
//  SceneCoordinatorExample
//
//  Created by Hairui on 20/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit
import SceneCoordinator

class PushAndPopBaseViewController : UIViewController{
    
    var tableView : UITableView!
    
    var data : [String]{
        return []
    }
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        navigationItem.title = String(describing: type(of: self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
}

// MARK: - Setup TableView
extension PushAndPopBaseViewController{
    private func setupTableView(){
        tableView = UITableView()
        tableView.registerCell(type: UITableViewCell.self)
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false 
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
        } else {
            NSLayoutConstraint.activate([
                // Fallback on earlier versions
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        }
        
        
        tableView.dataSource = self
    }
}

// MARK: - UiTableViewDataSource
extension PushAndPopBaseViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: UITableViewCell.self, indexPath: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
