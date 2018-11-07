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

    var arraySubjects:[String] = []
    var arrayDates:[String] = []
    var arrayDianisManis:[String] = []
    var arrayEvaluacionesDiana:[String] = []
    var arrayEvaluacionesMarcos:[String] = []
    var arrayEvaluacionesOtro:[String] = []
    
    let evaluadoresHeader:[String] = ["Marcos López Aquino", "Diana Vázquez Fosado", "Otro"]

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
                miMateria.implementador = dictionary["Implementador"] as? String
                
                print("--------------------------------")
                print(miMateria.materia!, miMateria.fecha!, miMateria.implementador!)
                
                switch miMateria.implementador{
                    //Caso Marcos
                case "Marcos López Aquino":
                    self.arrayEvaluacionesMarcos.append(miMateria.materia)
                    print("--------Se ha añadido una materia a Marcos--------")
                    
                    //Caso Diana
                case "Diana Vázquez Fosado":
                    self.arrayEvaluacionesDiana.append(miMateria.materia)
                    print("--------Se ha añadido una materia a Diana--------")
                    
                    //Caso otro
                default:
                    self.arrayEvaluacionesOtro.append(miMateria.materia)
                    print("--------Se ha añadido una materia a Otro--------")
                }
                
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
                cell.labelFecha.text = arrayDates[indexPath.row]
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
                cell.labelFecha.text = arrayDates[indexPath.row]
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
                cell.labelFecha.text = arrayDates[indexPath.row]
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
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                switch self.tableView.indexPathForSelectedRow?.section{
                case 0:
                    miMateria = arrayEvaluacionesMarcos[indexPath.row]
                case 1:
                    miMateria = arrayEvaluacionesDiana[indexPath.row]
                default:
                    miMateria = arrayEvaluacionesOtro[indexPath.row]
                }
                
                
                let destinationVC = segue.destination as! evaluacionDetailsVC
                destinationVC.docenteEvaluado = docenteSeleccionad
                destinationVC.materiaSeleccionada = miMateria
            }
            
        }
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var materia:String! = ""
        
        switch indexPath.section{
        case 0:
            materia = arrayEvaluacionesMarcos[indexPath.row]
        case 1:
            materia = arrayEvaluacionesDiana[indexPath.row]
        default:
            materia = arrayEvaluacionesOtro[indexPath.row]
        }
        
        let destinationVC = evaluacionDetailsVC()
        destinationVC.docenteEvaluado = docenteSeleccionad
        destinationVC.materiaSeleccionada = materia
        
        destinationVC.performSegue(withIdentifier: "segueDetallesEv", sender: self)
    }*/
}
