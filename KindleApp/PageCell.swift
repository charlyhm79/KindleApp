//
//  PageCell.swift
//  KindleApp
//
//  Created by Carlos Gonzalez on 10/09/2019.
//  Copyright © 2019 Carlos Gonzalez. All rights reserved.
//

import UIKit

class PageCell : UICollectionViewCell{
    
    
    let textLabel:UILabel = {
        
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.backgroundColor = .white
        //Especificar propiedad de las constrain sa false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Tamaño y posicion del lable
        
        //Añadir el Lable a nuestr vista padre
        addSubview(textLabel)
        
        textLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
