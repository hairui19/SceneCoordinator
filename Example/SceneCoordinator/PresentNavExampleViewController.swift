//
//  PresentNavExampleViewController.swift
//  SceneCoordinator_Example
//
//  Created by Hairui on 21/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SceneCoordinator

class PresentNavExampleViewController : UIViewController{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var viewButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewButtons.first?.isSelected = true
    }
    
    
    override func willRevealOnInterface(with data: [String : Any]) {
        if let data = data["data"] as? String{
            label.text = data
        }
    }
    
    
    @IBAction func present(_ sender: UIButton) {
        if let text = textField.text, text != ""{
            if viewButtons[0].isSelected && viewButtons[1].isSelected{
                SceneCoordinator<PresentNav>.presentNav(with: .navFirstChildViewController, .navSecondChildViewController, withData: ["data": text], animated: true)
            }else if viewButtons[0].isSelected{
                SceneCoordinator<PresentNav>.presentNav(with: .navFirstChildViewController, withData: ["data": text], animated: true)
            }else if viewButtons[1].isSelected{
                SceneCoordinator<PresentNav>.presentNav(with: .navSecondChildViewController, withData: ["data": text], animated: true)
            }
            
        }
    }

    @IBAction func firstViewClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func secondViewClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    
    
}
