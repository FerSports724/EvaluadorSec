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

struct pasar {
    var nombre:String!
    var materia:String!
}

class EvaluacionesTableVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    var idDocente = Int()
    var docenteSeleccionad = String()

    var arrayEvaluacionesDiana:[String] = []
    var arrayEvaluacionesMarcos:[String] = []
    var arrayEvaluacionesOtro:[String] = []
    var arrayClavesDiana:[String] = []
    var arrayClavesMarcos:[String] = []
    var arrayClavesOtro:[String] = []
    var arrayDatesMarcos:[String] = []
    var arrayDatesDiana:[String] = []
    var arrayDatesOtro:[String] = []
    
    let evaluadoresHeader:[String] = ["Marcos López Aquino", "Diana Vázquez Fosado", "Otro"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("El id del docente es: \(idDocente)")
        print("El nombre del docente seleccionado es: \(docenteSeleccionad)")
        self.title = docenteSeleccionad
        leerDatos()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func leerDatos(){
        
        //SVProgressHUD.show()
        let referenciaDB = Database.database().reference().child("\(docenteSeleccionad)")
        referenciaDB.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let miMateria = modeloEvaluacion()
                miMateria.materia = dictionary["Materia"] as? String
                miMateria.fecha = dictionary["Fecha"] as? String
                miMateria.clave = dictionary["Clave"] as? String
                miMateria.implementador = dictionary["Implementador"] as? String
                
                switch miMateria.implementador{
                    //Caso Marcos
                case "Marcos López Aquino":
                    self.arrayEvaluacionesMarcos.append(miMateria.materia)
                    self.arrayClavesMarcos.append(miMateria.clave)
                    self.arrayDatesMarcos.append(miMateria.fecha)
                    print("--------Se ha añadido una materia a Marcos--------")
                    
                    //Caso Diana
                case "Diana Vázquez Fosado":
                    self.arrayEvaluacionesDiana.append(miMateria.materia)
                    self.arrayClavesDiana.append(miMateria.clave)
                    self.arrayDatesDiana.append(miMateria.fecha)
                    print("--------Se ha añadido una materia a Diana--------")
                    
                    //Caso otro
                default:
                    self.arrayEvaluacionesOtro.append(miMateria.materia)
                    self.arrayClavesOtro.append(miMateria.clave)
                    self.arrayDatesOtro.append(miMateria.clave)
                    print("--------Se ha añadido una materia a Otro--------")
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //SVProgressHUD.dismiss(withDelay: 0.5)
                }
                
            }else{
                print("--------------------")
                print("No hay resultados para este mai.")
                //SVProgressHUD.dismiss(withDelay: 0.5)
            }

        }, withCancel: nil)
        
    }

}

extension EvaluacionesTableVC: UITableViewDataSource{
    
}

extension EvaluacionesTableVC: UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return evaluadoresHeader.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
            case 0:
                if arrayEvaluacionesMarcos.count > 0{
                    return arrayEvaluacionesMarcos.count
                }else{
                    return 1
            }
            
            case 1:
                if arrayEvaluacionesDiana.count > 0{
                    return arrayEvaluacionesDiana.count
                }else{
                    return 1
            }
            default:
                if arrayEvaluacionesOtro.count > 0{
                    return arrayEvaluacionesOtro.count
                }else{
                    return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaEvaluaciones", for: indexPath) as! celdaTablaEvaluaciones
        
        switch indexPath.section{
        case 0:
            if arrayEvaluacionesMarcos.count > 0{
                cell.labelMateria.text = arrayEvaluacionesMarcos[indexPath.row]
                cell.labelFecha.text = arrayDatesMarcos[indexPath.row]
                cell.accessoryType = .disclosureIndicator
                cell.isUserInteractionEnabled = true
                return cell
            }else{
                cell.labelMateria.text = "No hay evaluaciones registradas."
                cell.labelFecha.text = ""
                cell.isUserInteractionEnabled = false
                return cell
            }
            
        case 1:
            if arrayEvaluacionesDiana.count > 0{
                cell.labelMateria.text = arrayEvaluacionesDiana[indexPath.row]
                cell.labelFecha.text = arrayDatesDiana[indexPath.row]
                cell.accessoryType = .disclosureIndicator
                cell.isUserInteractionEnabled = true
                return cell
            }else{
                cell.labelMateria.text = "No hay evaluaciones registradas."
                cell.labelFecha.text = ""
                cell.isUserInteractionEnabled = false
                return cell
            }
            
        default:
            if arrayEvaluacionesOtro.count > 0{
                cell.labelMateria.text = arrayEvaluacionesOtro[indexPath.row]
                cell.labelFecha.text = arrayDatesOtro[indexPath.row]
                cell.accessoryType = .disclosureIndicator
                cell.isUserInteractionEnabled = true
                return cell
            }else{
                cell.labelMateria.text = "No hay evaluaciones registradas."
                cell.labelFecha.text = ""
                cell.isUserInteractionEnabled = false
                return cell
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return evaluadoresHeader[section]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetallesEv"{
            
            var miMateria:String! = ""
            var clave:String! = ""
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                switch self.tableView.indexPathForSelectedRow?.section{
                case 0:
                    miMateria = arrayEvaluacionesMarcos[indexPath.row]
                    clave = arrayClavesMarcos[indexPath.row]
                case 1:
                    miMateria = arrayEvaluacionesDiana[indexPath.row]
                    clave = arrayClavesDiana[indexPath.row]
                default:
                    miMateria = arrayEvaluacionesOtro[indexPath.row]
                    clave = arrayClavesOtro[indexPath.row]
                }
                
                
                let destinationVC = segue.destination as! evaluacionDetailsVC
                destinationVC.docenteEvaluado = docenteSeleccionad
                destinationVC.materiaSeleccionada = miMateria
                destinationVC.claveMateria = clave
            }
            
        }
        
        if segue.identifier == "segueNuevo"{
            let pantallNuevaEvaluacion = segue.destination as! nuevaEvaluacionVC
            pantallNuevaEvaluacion.docenteEvaluar = docenteSeleccionad
        }
    }
}
