//
//  SecondViewController.swift
//  SceneCoordinatorExample
//
//  Created by Hairui on 20/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit
import SceneCoordinator

class SecondViewController : PushAndPopBaseViewController{
    
    
    // MARK: - Navigations
    var viewControllerData : [String : Any] = [:]
    lazy var someCloseure = {
       return SceneCoordinator<Main>.push(to: .thirdViewController, withData: self.viewControllerData, animated: true)
    }
    
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
        print("SecondViewController Input Data: - \(data)")
    }
    
    override func willRevealOnInterface(with data: [String : Any]) {
        print("SecondViewController reveal again Data: - \(data)")
    }
    
    deinit {
        print("Deiniting secondViewController")
    }
    
}

// MARK: - UITableViewDelegate
extension SecondViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch data[indexPath.row] {
        case "Pop":
//            SceneCoordinator<Main>.popToPrevious()
            break
        case "Push":
            _ = someCloseure()
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


