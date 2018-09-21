//
//  FirstViewController.swift
//  SceneCoordinatorExample
//
//  Created by Hairui on 20/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit
import SceneCoordinator

class FirstViewController : PushAndPopBaseViewController{
    
    // MARK: - Input data
    private var name : String!
    private var age : Int!
    
    override var data: [String]{
        return [
            "Pop",
            "Push"
        ]
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
    }
    
    override func willMoveToInterface(with data: [String : Any]) {
        
        print("FirstViewController Input Data: - \(data)")
    }

    
    override func willRevealOnInterface(with data: [String : Any]) {
        print("FirstViewController reveal again Data: - \(data)")
    }
    
    deinit {
        print("Deiniting firstViewController")
    }
    
}

// MARK: - UITableViewDelegate
extension FirstViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch data[indexPath.row] {
        case "Pop":
//            SceneCoordinator<Main>.popToPrevious()
            break
        case "Push":
            SceneCoordinator<Main>.push(to: .secondViewController, withData: ["data":"FromFirstViewController"], animated: true)
        default:
            break
        }
    }
}







