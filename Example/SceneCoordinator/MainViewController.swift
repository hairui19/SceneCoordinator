//
//  MainViewController.swift
//  SceneCoordinatorExample
//
//  Created by Hairui on 20/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit
import SceneCoordinator

class MainViewController : UIViewController{
    
    // MARK: - IBOulets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var data : [String] = [
        "Push & Pop",
        "Present and Dismiss (Single UIViewController)",
        "Present and Dismiss (With NavigationController)",
        "Present and Dismiss (With UITabBarControler)"
    ]
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
//        let dataType :
    }
    
}

// MARK: - Setup TableView
extension MainViewController{
    private func setupTableView(){
        // registering cells
        tableView.registerCell(type: UITableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
    }
}

// MARK: - UITableViewDelegate
extension MainViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            SceneCoordinator<Main>.push(to: .firstViewController, withData: ["data" : "FromMain"], animated: true)
        case 1:
            SceneCoordinator<PresentSingleView>.push(to: .presentSingleViewExampleViewController, animated: true)
        case 2:
            break
        case 3:
            break
        default:
            break
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: UITableViewCell.self, indexPath: indexPath)
        let displayText = data[indexPath.row]
        cell.textLabel?.text = displayText
        return cell
    }
}
