//
//  UITableView+Extension.swift
//  Donghong
//
//  Created by Donghong on 2019/3/11.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

protocol RegisterCellOrNib {}
extension RegisterCellOrNib {
    static var identifier: String {
        return "\(self)"
    }
    
    static var nib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}

extension UITableView {
    func ym_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        }else{
            
        }
    }
    
    func ym_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
