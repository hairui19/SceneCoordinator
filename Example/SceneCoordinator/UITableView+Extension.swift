//
//  UITableView+Extension.swift
//  SceneCoordinatorExample
//
//  Created by Hairui on 20/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit

extension UITableView{
    
    public func registerCell<T : UITableViewCell>(type : T.Type){
        let cellname = String(describing: type)
        register(type, forCellReuseIdentifier: cellname)
    }
    
    public func registerCellWithNib<T : UITableViewCell>(with type : T.Type){
        let cellname = String(describing: type)
        let nib = UINib(nibName: cellname, bundle: nil)
        register(nib, forCellReuseIdentifier: cellname)
    }
    
    public func dequeueCell<T: UITableViewCell>(with type : T.Type, indexPath : IndexPath)->T{
        let cellname = String(describing: type)
        return dequeueReusableCell(withIdentifier: cellname, for: indexPath) as! T
        
    }
    
}

