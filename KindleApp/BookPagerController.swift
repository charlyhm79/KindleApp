//
//  BookPagerController.swift
//  KindleApp
//
//  Created by Carlos Gonzalez on 06/09/2019.
//  Copyright © 2019 Carlos Gonzalez. All rights reserved.
//

import UIKit

class BookPagerController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    var book: Book?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        self.navigationItem.title = self.book?.title
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleCloseBook))
        
        
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        
        
        //Reducir el espacio entre items de un CollectionView a cero
        layout?.minimumLineSpacing = 0
        
        collectionView?.isPagingEnabled = true
        
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book?.pages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Dvolver que las paginas midan toda la pantalla de VC
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    @objc func handleCloseBook() {
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = book?.pages[indexPath.item]
        
        pageCell.textLabel.text = page?.text
        
        return pageCell
    }

}
