//
//  ViewController.swift
//  KindleApp
//
//  Created by Carlos Gonzalez on 03/09/2019.
//  Copyright © 2019 Carlos Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarStyles()
        
        setupNavBarButtons()
        
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        
        navigationItem.title = "Kindle"
        
        fetchBooks()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        //Creamos control Segmentado
        //1º.Crear variable o constante pera almacenar objeto
        //2º.Crear objeto y lo asignamos a la constante
        let segmentedControl = UISegmentedControl(items: ["Cloud","Device"])
        
        //Hacer que nuestro SC sea blanco
        segmentedControl.tintColor = .white
        
        //Cloud seleccionado por defecto
        
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        //3º.Añadir el segmented control a nuestro footer
        footerView.addSubview(segmentedControl)
        
        //El ancho de nuestro SC sea 200
        segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //El alto sea de 30
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //Hacemos que este centrado en el eje X del footer
        segmentedControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        //que este centrado en el eje Y del footer
        segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        //Creamos el boton gridButton del tipo sistema
        let gridButton = UIButton(type: .system)
        
        //Añadimos la imagen al boton gridButton
        gridButton.setImage(#imageLiteral(resourceName: "grid").withRenderingMode(.alwaysOriginal), for: .normal)
        
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        
        //Añadir el boton al footer gridButton
        footerView.addSubview(gridButton)
        
        //Usar las constrains gridButton
        gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor,constant: 8).isActive = true
        gridButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        
        gridButton.addTarget(self, action: #selector(handleGridPress), for: .touchUpInside)
        
        
        //Creamos el boton SortButton del tipo sistema
        let sortButton = UIButton(type: .system)
        sortButton.setImage(#imageLiteral(resourceName: "sort").withRenderingMode(.alwaysOriginal), for: .normal)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(sortButton)
        
        sortButton.addTarget(self, action: #selector(handleSortPress), for: .touchUpInside)
        //Usar las constrains del SortButton
        sortButton.rightAnchor.constraint(equalTo: footerView.rightAnchor,constant: -8).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        
        return footerView
    }
    
    @objc func handleGridPress(){
        print("gridButton Pressed")
        
    }
    
    @objc func handleSortPress(){
        print("sortButton Pressed")
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func setupNavBarButtons(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuPress))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "amazon_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAmazonPress))
    }
    
    @objc func handleMenuPress(){
      print("menu button pressed")
    }
    @objc func handleAmazonPress(){
        print("Amazon button pressed")
    }
    
    
    func  setupNavigationBarStyles(){
        
        //Acceder a la propiedad backgroundColor dela NavBar y asignarle el color negro
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        //Propiedad  TitleTextAtributtes den la NavigationBar
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
   
    
    
    func fetchBooks(){
        print("Fetching books...")
        if let url = URL(string: "https://private-40c611-kindleapi5.apiary-mock.com/books"){
            URLSession.shared.dataTask(with: url ,completionHandler:  { (data, response, error) in
                
                if let err = error{
                    print("Failed to fetch external json books: ",err)
                    return
                }
                
                guard let data = data else {return}
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    guard let bookDictionaries = json as? [[String:Any]] else {return}
                    
                    //recorer array de diccionarios
                    
                    self.books = []
                    
                    for bookDictionary in bookDictionaries{
                        let book = Book(dictionary: bookDictionary)
                        self.books?.append(book)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                   //self.tableView.reloadData()
                    
                }catch let jsonError {
                    print("Failed to parse JSON properly",jsonError)
                }
                
               
            }).resume()
            
            
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = books?.count{
            return count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        
        let book = books?[indexPath.row]
        
        cell.book = book
        
        return cell
        
       
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedBook = self.books?[indexPath.row]
        
        
        
        let layout = UICollectionViewFlowLayout()
        let bookPagerController = BookPagerController(collectionViewLayout: layout)
        bookPagerController.book = selectedBook
        
        let navigationController = UINavigationController(rootViewController: bookPagerController)
        
        present(navigationController, animated: true, completion: nil)
    }
    
   

}



