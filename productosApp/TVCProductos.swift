//
//  TVCProductos.swift
//  productosApp
//
//  Created by Nicthea Alvarez Platas on 4/4/19.
//  Copyright © 2019 Efrain Alvarez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class TVCProductos: UITableViewCell {

    @IBOutlet weak var laMarca: UILabel!
    @IBOutlet weak var laCodigo: UILabel!
    @IBOutlet weak var laDescripcion: UITextView!
    @IBOutlet weak var laModelo: UILabel!
    @IBOutlet weak var laStock: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setProducto(producto:Producto){
        laCodigo.text = producto.codigo
        print(producto.codigo)
        laMarca.text = producto.marca
        print(producto.marca)
        laDescripcion.text = producto.descripcion
        print(producto.descripcion)
        laModelo.text = producto.modelo
        print(producto.modelo)
        laStock.text = producto.stock
        print(producto.stock)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
