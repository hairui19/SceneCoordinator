//
//  ThirdViewController.swift
//  SceneCoordinatorExample
//
//  Created by Hairui on 20/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit
import SceneCoordinator

class ThirdViewController : PushAndPopBaseViewController{
    
    override var data: [String]{
        return [
            "Pop",
            "Push",
            "PopToFirst"
        ]
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
    }
    
    override func willMoveToInterface(with data: [String : Any]) {
        print("ThirdViewController Input Data: - \(data)")
    }
    
    override func willRevealOnInterface(with data: [String : Any]) {
        print("ThirdViewController reveal again Data: - \(data)")
    }
    
    deinit {
        print("Deiniting ThirdViewController")
    }
    
}

// MARK: - UITableViewDelegate
extension ThirdViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch data[indexPath.row] {
        case "Pop":
//            SceneCoordinator<Main>.popToPrevious()
            break
        case "Push":
            SceneCoordinator<Main>.push(to: .fourthViewController, withData: ["data" : "FromThirdViewController"], animated: true)
        case "PopToFirst":
//            SceneCoordinator<Main>.pop(to: .firstViewController, withData: ["data" : "FromThirdViewController"], animated: true)
            break
        default:
            break
        }
    }
}



