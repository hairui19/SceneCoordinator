//
//  TabTwoViewController.swift
//  SceneCoordinator_Example
//
//  Created by Hairui on 21/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SceneCoordinator

class TabTwoViewController : UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addALabel()
    }
    
    private func addALabel(){
        let label = UILabel()
        label.text = "Hi, i am Tab Second"
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    override func willRevealOnInterface(with data: [String : Any]) {
        if let _ = data["push"]{
            SceneCoordinator<Main>.push(to: .tabTwoPushedViewController, animated: false)
        }
    }
    
}
