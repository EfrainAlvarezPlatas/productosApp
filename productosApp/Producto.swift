//
//  Producto.swift
//  productosApp
//
//  Created by Nicthea Alvarez Platas on 4/4/19.
//  Copyright © 2019 Efrain Alvarez. All rights reserved.
//

import UIKit

class Producto{
    var idprod:String?
    var codigo:String?
    var modelo:String?
    var marca:String?
    var stock:String?
    var descripcion:String?
    
    init(idprod:String,codigo:String?,modelo:String?,marca:String?,stock:String?,descripcion:String?) {
        self.idprod = idprod
        self.codigo = codigo
        self.modelo = modelo
        self.marca = marca
        self.stock = stock
        self.descripcion = descripcion
    }
}
