//
//  FourthViewController.swift
//  SceneCoordinatorExample
//
//  Created by Hairui on 20/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit
import SceneCoordinator

class FourthViewController : PushAndPopBaseViewController{
    
    override var data: [String]{
        return [
            "Pop",
            "PopToFirst",
            "PopToSecond"
        ]
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
    }
    
    override func willMoveToInterface(with data: [String : Any]) {
        print("FourthViewController Input Data: - \(data)")
    }
    
    deinit {
        print("Deiniting FourthViewController")
    }
    
}

// MARK: - UITableViewDelegate
extension FourthViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch data[indexPath.row] {
        case "Pop":
            SceneCoordinator<Main>.popToPrevious(animated: true)
        case "PopToFirst":
            SceneCoordinator<Main>.pop(to: .firstViewController, withData: ["data":"FromFourthViewController"], animated: true)
        case "PopToSecond":
            SceneCoordinator<Main>.pop(to: .secondViewController, withData: ["data":"FromFourthViewController"], animated: true)
            
        default:
            break
        }
    }
}

