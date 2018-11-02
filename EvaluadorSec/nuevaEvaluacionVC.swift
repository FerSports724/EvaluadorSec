//
//  nuevaEvaluacionVC.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 29/10/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit

class nuevaEvaluacionVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnIniciar: UIButton!
    @IBOutlet var btnCancelar: UIButton!
    @IBOutlet var viewDatos: UIView!
    
    let arrayPlaceHolder:[String] = ["Docente", "Fecha", "Idioma", "Grado y grupo", "Materia", "Implementador"]
    let arrayImages:[String] = ["iconUser", "iconDate", "iconLanguage", "iconGroup", "iconSubject", "iconEvaluator"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDatos.layer.cornerRadius = 10
    }
    
    @IBAction func iniciarEvaluacion(_ sender: UIButton) {
    }
    
    @IBAction func cancelar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension nuevaEvaluacionVC: UITableViewDataSource{
    
}

extension nuevaEvaluacionVC: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPlaceHolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let placeholderText = arrayPlaceHolder[indexPath.row]
        let imageIcon = arrayImages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaDatos", for: indexPath) as! celdaDatos
        cell.textFieldFila.placeholder = placeholderText
        cell.iconoFila.image = UIImage(named: imageIcon)
        return cell
        
    }
}
