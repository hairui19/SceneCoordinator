//
//  PresentSingleViewController.swift
//  SceneCoordinator_Example
//
//  Created by Hairui on 21/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SceneCoordinator

class PresentSingleFirstViewController : UIViewController{
    
    
    // MARK: - IBOulets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: Properties
    var theData : String = "No Data Paassed"
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        navigationItem.title = String(describing: type(of: self))
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = theData
        label.sizeToFit()
        
    }
    @IBAction func dismissView(_ sender: UIButton) {
        if let text = textField.text, text != ""{
            SceneCoordinator<Nav>.dismiss(withData: ["data":text], animated: true)
        }else{
            SceneCoordinator<Nav>.dismiss(animated: true)
        }
        
    }
    
    override func willMoveToInterface(with data: [String : Any]) {
        if let text = data["data"] as? String{
            theData = text
        }
        
    }
    
}
