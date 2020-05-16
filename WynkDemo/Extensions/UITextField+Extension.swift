//
//  UIImage+Extension.swift
//  WynkDemo
//
//  Created by Smriti on 14/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import UIKit

extension UITextField{
    
    func setRightImage(){
        
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(named: "dropdownImage")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        view.backgroundColor = .clear
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.25).cgColor
        
        self.layer.borderWidth = 0
        self.leftViewMode = UITextField.ViewMode.always
        self.leftView = view
        self.placeholder = "Search "
        
    }
    
}
