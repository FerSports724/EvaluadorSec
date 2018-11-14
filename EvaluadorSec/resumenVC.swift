//
//  resumenVC.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 13/11/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

struct pruebaDocentes {
    var observaciones:String!
    var docente:String!
}

class resumenVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var miEvaluacion = modeloEvaluacion()
    var pruebitaEv:[pruebaDocentes] = [pruebaDocentes]()
    
    var docente = String()
    var materia = String()
    
    var arrayObservatorio:[String] = []
    
    let sectionHeaders:[String] = ["Datos del docente", "Observaciones", "Inicio de clase", "Desarrollo de clase", "Cierre de clase", "Inteligencias Múltiples", "Inteligencia Emocional", "Aprendizaje Colaborativo", "Planificación", "Programa", "Recursos y Herramientas"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Docente: \(docente)")
        print("Materia: \(materia)")
        
        //leerDatos()
        enriquePenaNieto()
        //chabelo()
    }
    
    /*Espero esta si sea la buena*/
    func estaQueSeaLaBuena(){
        let referencia = Database.database().reference().child("\(docente)").child("\(materia)")
        referencia.observe(.value) { snapshot in
            for child in snapshot.children{
                print("----: \(child)")
                if let dict = child as? [String:AnyObject]{
                    let ocservancias = dict["Observaciones"] as? String
                    print(ocservancias ?? "Holis")
                }else{
                    print("Aquí hay algo de amor.")
                }
            }
        }
    }
    
    /*Otra forma de leer*/
    func enriquePenaNieto(){
        
        print("Estamos arrrrrrrrrrrrrrrrrrrrancando el juego.")
        
        let referencia = Database.database().reference().child("\(docente)").child("\(materia)")
        referencia.observeSingleEvent(of: .value) { (snapchot) in
            let value = snapchot.value as? NSDictionary
            let observatorio = value?["Observaciones"] as? String
            self.arrayObservatorio.append(observatorio!)
            let materiaPrima = value?["Materia"] as? String
            let poner = pruebaDocentes(observaciones: observatorio, docente: materiaPrima)
            self.pruebitaEv.append(poner)
            print("Colate un dedo cabezona, colate un dedo.")
            print(self.pruebitaEv.count)
            print("-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-")
            print("\(self.pruebitaEv[0].docente!)")
            print("asndfjdnfjkanfjerfuierferf")
            self.tableView.reloadData()
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "celdaObservaciones") as! celdaObservaciones
            cell.labelObservaciones.text = self.arrayObservatorio[0]
            
            print("Hola: \(self.arrayObservatorio.count)")
            
            DispatchQueue.main.async {
                print("ñ---------------------------ñ")
                print("\(self.pruebitaEv.count)")
            }
            
        }
        
        print("Soy Emilio Fernando Alonso.")
        
    }
    
    /*Vamos a ver si esta si*/
    func chabelo(){
        let referencia = Database.database().reference().child("\(docente)").child("\(materia)")
        referencia.observeSingleEvent(of: .value) { (snapchat) in
            guard let value = snapchat.value as? NSDictionary else{
                print("No hay registros ome")
                return
            }
            
            for registros in value{
                let dictionary = registros.value as! NSDictionary
                
                let observciones = dictionary["Observaciones"] as? String
                self.arrayObservatorio.append(observciones!)
            }
            
            print(self.arrayObservatorio.count)
        }
    }

}

extension resumenVC: UITableViewDataSource{
    
}

extension resumenVC: UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 7
        case 1:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            let cell01 = tableView.dequeueReusableCell(withIdentifier: "celdaDatos")
            cell01?.textLabel?.text = "Soy la celda 01"
            return cell01!
        case 1:
            let cell02 = tableView.dequeueReusableCell(withIdentifier: "celdaObservaciones") as! celdaObservaciones
            //cell02.labelObservaciones.text = arrayObservatorio[indexPath.row]
            //cell02.labelObservaciones.text = huehues.observaciones
            return cell02
        default:
            let cell03 = tableView.dequeueReusableCell(withIdentifier: "celdaResultados")
            cell03?.textLabel?.text = "Soy la celda 03"
            return cell03!
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
    
}
