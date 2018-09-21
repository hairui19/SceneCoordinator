//
//  PresentSingleViewExampleViewController.swift
//  SceneCoordinator_Example
//
//  Created by Hairui on 21/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SceneCoordinator

class PresentSingleViewExampleViewController : UIViewController{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var transitionDelegate = CustomTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func present(_ sender: UIButton) {
        
        if let text = textField.text, text != ""{
            SceneCoordinator<PresentSingleView>.present(scene: .presentSingleFirstViewController, withData: ["data" : text], transitionDelegate: transitionDelegate, animated: true)
//            SceneCoordinator<PresentSingleView>.present(scene: .presentSingleFirstViewController, withData: ["data" : text], animated: true)
        }
        
    }
    
    override func willRevealOnInterface(with data: [String : Any]) {
        if let data = data["data"] as? String{
            label.text = data
        }
        label.sizeToFit()
    }
    
    
}
