//
//  PresentFirstChildViewController.swift
//  SceneCoordinator_Example
//
//  Created by Hairui on 21/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SceneCoordinator

class NavFirstChildViewController : UIViewController{
    
    // MARK: - Properties
    var labelContent : String = ""
    
    // MARK: - IBOulets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        navigationItem.title = String(describing: type(of: self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = labelContent
    }
    
    
    override func willMoveToInterface(with data: [String : Any]) {
        if let data = data["data"] as? String{
            labelContent = data
        }
    }
    
    @IBAction func dismisss(_ sender: UIButton) {
        if let text = textField.text, text != ""{
            SceneCoordinator<Nav>.dismiss(withData: ["data":text], animated: true)
        }
    }
    
}
