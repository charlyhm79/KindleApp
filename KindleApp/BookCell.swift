//
//  BookCell.swift
//  KindleApp
//
//  Created by Carlos Gonzalez on 04/09/2019.
//  Copyright © 2019 Carlos Gonzalez. All rights reserved.
//

import UIKit


class BookCell: UITableViewCell {
    
    
    var book: Book?{
        didSet{
            titleLabel.text = book?.title
            authorLabel.text = book?.author
           
            guard let coverImageUrl = book?.coverImageUrl else {return}
            guard let url = URL(string:coverImageUrl ) else {return}
            
            self.coverImageView.image = nil
            

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let err = error {
                    print("Failed to retrieve our books cover images: ",err)
                    return
                }
                
                //Desempaquetamoos Data  de forma segura
                
                guard let imageData = data else {return}
                
                //creamos nuestro objeto UIImage a partir de data
                 let image = UIImage(data: imageData)
                
                //Asignamos el objeto UIImage  propiedad coverImageView
                DispatchQueue.main.async {
                    self.coverImageView.image = image
                }
                
                
            }.resume()
            
        }
    }
    
    
    
    let coverImageView :UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "steve_jobs")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Texto Titulo del libro"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let authorLabel : UILabel = {
        let label = UILabel()
        label.text = "Texto Autor del libro"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        backgroundColor = .clear
        
        self.addSubview(coverImageView)
        coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 8).isActive = true
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant:-8).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        self.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        
        self.addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 4).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
