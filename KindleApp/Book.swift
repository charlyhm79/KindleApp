//
//  Book.swift
//  KindleApp
//
//  Created by Carlos Gonzalez on 03/09/2019.
//  Copyright © 2019 Carlos Gonzalez. All rights reserved.
//

import UIKit

class Book {
    
    let title: String
    let author: String
    let pages:[Page]
    let coverImageUrl: String
    
    init(dictionary:[String:Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        self.coverImageUrl = dictionary["coverImageUrl"] as? String ?? ""
       
        
        var bookPages = [Page]()
        
        if let pagesDictionaries = dictionary["pages"] as? [[String:Any]]{
            
            for pageDictionary in pagesDictionaries{
                
                if let pageText = pageDictionary["text"] as? String{

                let page = Page(number: 1, text: pageText)
                  bookPages.append(page)
             }
            
          }
        }
        self.pages = bookPages
    }
}
