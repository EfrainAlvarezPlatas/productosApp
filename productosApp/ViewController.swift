//
//  ViewController.swift
//  productosApp
//
//  Created by Nicthea Alvarez Platas on 4/4/19.
//  Copyright © 2019 Efrain Alvarez. All rights reserved.
//

import UIKit
import FirebaseDatabase
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var txtCodigo: UITextField!
    @IBOutlet weak var txtModelo: UITextField!
    @IBOutlet weak var txtMarca: UITextField!
    @IBOutlet weak var txtStock: UITextField!
    @IBOutlet weak var txtDescripcion: UITextView!
    
    
    @IBOutlet weak var laProductoList: UITableView!
    
    
    var ref = DatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        loadProductos()
        // Do any additional setup after loading the view.
        laProductoList.delegate = self
        laProductoList.dataSource = self
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfProductos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellProductos:TVCProductos = tableView.dequeueReusableCell(withIdentifier: "Productos", for: indexPath) as! TVCProductos
        cellProductos.setProducto(producto: listOfProductos[indexPath.row])
        return cellProductos
    }
    
    var listOfProductos = [Producto]()
    func loadProductos(){
        self.ref.child("productos").observe( .value, with:
            {(snapshot) in
                self.listOfProductos.removeAll()
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                    for snap in snapshot{
                        if let prodData = snap.value as? [String:AnyObject]{
                            let idprod = snap.key as? String
                            print(idprod!)
                            let codigo = prodData["codigo"] as? String
                            print(codigo!)
                            let modelo = prodData["modelo"] as? String
                            print(modelo!)
                            let marca = prodData["marca"] as? String
                            print(marca!)
                            let stock = prodData["stock"] as? String
                            print(stock!)
                            let descripcion = prodData["descripcion"] as? String
                            print(descripcion!)
                            self.listOfProductos.append(Producto(idprod:idprod!, codigo: codigo, modelo: modelo, marca: marca, stock: stock, descripcion: descripcion))
                            print("prods: ", self.listOfProductos)
                        }
                    }
                    self.laProductoList.reloadData()
                    let indexpath = IndexPath(row: self.listOfProductos.count, section: 0)
                    //self.laProductoList.scrollToRow(at: indexpath, at: .bottom, animated: true)
                }
        })
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let producto = listOfProductos[indexPath.row]
        let alertController = UIAlertController(title: producto.codigo, message: "Inserta nuevos valores", preferredStyle: .alert)
       let confirmAction = UIAlertAction(title: "Editar", style: .default){ (_) in
            let idprod = producto.idprod
            let codigo = alertController.textFields?[0].text
            let modelo = alertController.textFields?[1].text
            let marca = alertController.textFields?[2].text
            let stock = alertController.textFields?[3].text
            let descripcion = alertController.textFields?[4].text
        
        self.updateProd(idprod: idprod!, codigo:codigo!, modelo:modelo!, marca:marca!, stock:stock!, descripcion:descripcion!)
        
        }
        
        let cancelAction = UIAlertAction(title: "Eliminar", style: .cancel) { (_) in
            self.deleteProd(idprod:producto.idprod!)
        }
        
        //adding two textfields to alert
        alertController.addTextField { (textField) in
            textField.text = producto.codigo
        }
        alertController.addTextField { (textField) in
            textField.text = producto.modelo
        }
        alertController.addTextField { (textField) in
            textField.text = producto.marca
        }
        alertController.addTextField { (textField) in
            textField.text = producto.stock
        }
        alertController.addTextField { (textField) in
            textField.text = producto.descripcion
        }
        
        //adding action
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //presenting dialog
        present(alertController, animated: true, completion: nil)
    }
    
    func deleteProd(idprod:String){
        let ref = Database.database().reference().root.child("productos")
        ref.child(idprod).removeValue()
        print("Producto eliminado: \(idprod)")
    }
    
    func updateProd(idprod:String, codigo:String, modelo:String, marca:String,stock:String, descripcion:String){
        //creating artist with the new given values
        let producto = ["idprod":idprod, "codigo":codigo, "modelo":modelo,"marca":marca,"stock":stock, "descripcion":descripcion]
        let ref = Database.database().reference().root.child("productos").child((idprod))
        ref.updateChildValues(["codigo":codigo,"modelo":modelo,"marca":marca,"stock":stock, "descripcion":descripcion])
        print("Producto actualizado: \(idprod)")
    }

    @IBAction func btnGuardar(_ sender: Any) {
        let modelo = txtModelo.text
        let marca = txtMarca.text
        let codigo = txtCodigo.text
        let descripcion = txtDescripcion.text
        let stock = txtStock.text
        print("click a boton de guardar")
        
        let ref = Database.database().reference().child("productos")
        ref.childByAutoId().setValue(["codigo":codigo!,"modelo":modelo!,"marca":marca!,"stock":stock!,"descripcion":descripcion!])
        self.laProductoList.reloadData()
        
        txtCodigo.text = ""
        txtModelo.text = ""
        txtMarca.text = ""
        txtStock.text = ""
        txtDescripcion.text = ""
    }
    

}

