//
//  UICollection+Extension.swift
//  Donghong
//
//  Created by Donghong on 2019/3/11.
//  Copyright © 2019 Donghong. All rights reserved.
//

import UIKit

extension UICollectionView {
    func ym_registerCell<T: UICollectionViewCell>(cell: T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.identifier)
        }else{
            register(cell, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    func ym_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
