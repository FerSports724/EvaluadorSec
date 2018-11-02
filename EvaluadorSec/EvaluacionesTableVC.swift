//
//  EvaluacionesTableVC.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 24/10/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

struct materias {
    let nombreMateria:String!
    let fechaEvaluacion:String!
}

class EvaluacionesTableVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var arrayEvaluaciones:[modeloEvaluacion] = []
    var arrayMais:[modeloMaestro] = []
    var idDocente = Int()
    var docenteSeleccionad = String()
    
    var arrayMaterias = [materias]()
    var materiasMaestro = [modeloEvaluacion]()
    var arraySubjects:[String] = []
    var arrayDates:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("El id del docente es: \(idDocente)")
        print("El nombre del docente seleccionado es: \(docenteSeleccionad)")
        leerDatos()
        
    }
    
    func leerDatos(){
        
        //SVProgressHUD.show()
        let referenciaDB = Database.database().reference().child("\(docenteSeleccionad)")
        referenciaDB.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let miMateria = modeloEvaluacion()
                miMateria.materia = dictionary["Materia"] as? String
                miMateria.fecha = dictionary["Fecha"] as? String
                print("--------------------------------")
                print(miMateria.materia!, miMateria.fecha!)
                self.arraySubjects.append(miMateria.materia)
                self.arrayDates.append(miMateria.fecha)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }else{
                print("--------------------")
                print("No hay resultados para este mai.")
            }
            
            //print(snapshot)
        }, withCancel: nil)
        
    }

}

extension EvaluacionesTableVC: UITableViewDataSource{
    
}

extension EvaluacionesTableVC: UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySubjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaEvaluaciones", for: indexPath) as! celdaTablaEvaluaciones
        cell.labelMateria.text = arraySubjects[indexPath.row]
        //cell.textLabel?.text = materiasMaestro[indexPath.row].nombreMateria
        return cell
    }
}
