//
//  modeloMaestro.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 23/10/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import Foundation

class modeloMaestro{
    var nombre:String!
    var identificador:String!
    var idioma:String!
    var imagen:String!
    
    init(nombre:String, identificador:String, idioma:String, imagen:String) {
        self.nombre = nombre
        self.identificador = identificador
        self.idioma = idioma
        self.imagen = imagen
    }
}
