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

class resumenVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var myRef:DatabaseReference!
    
    var docente = String()
    var materia = String()
    
    var lasObservaciones = ""
    
    let sectionHeaders:[String] = ["Datos del docente", "Observaciones", "Inicio de clase", "Desarrollo de clase", "Cierre de clase", "Inteligencias Múltiples", "Inteligencia Emocional", "Aprendizaje Colaborativo", "Planificación", "Programa", "Recursos y Herramientas"]
    
    let arrayTituloDatos:[String] = ["Docente:", "Materia:", "Grupo:", "Idioma:", "Fecha:", "Implementador:"]
    var arrayDatos:[String] = ["Tacos de canasta", "Tacos", "Lleve sus tacos", "Panotla", "Tlaxcala", "Totolac", "Santa Justina Ecatepec"]
    
    let cantidadCeldas:[Int] = [2, 6, 1, 1, 2, 4, 2, 3, 6]
    
    var arrayResultadoRubros:[Int] = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    
    var arrayEvaluacion:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Resumen De La Evaluación"
        jalarArray()
        myRef = Database.database().reference()
        
        print("Docente: \(docente)")
        print("Materia: \(materia)")
        
        downloadData()
    }
    
    /*Jalar array del Plist*/
    func jalarArray(){
        if let URL = Bundle.main.url(forResource: "Rubros", withExtension: "plist") {
            if let miRubro = NSArray(contentsOf: URL) as? [String] {
                arrayEvaluacion = miRubro
            }
        }
    }
    
    /*Espero esta si sea la buena*/
    func downloadData(){
        myRef.child(docente).child(materia).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let miObservancia = value?["Observaciones"] as? String ?? ""
            
            let nombreDocente = value?["Docente"] as? String ?? ""
            let materiaDocente = value?["Materia"] as? String ?? ""
            let fechaDocente = value?["Fecha"] as? String ?? ""
            let grupoDocente = value?["Grupo"] as? String ?? ""
            let idiomaDocente = value?["Idioma"] as? String ?? ""
            let aplicadorDocente = value?["Implementador"] as? String ?? ""
            
            self.arrayDatos[0] = nombreDocente
            self.arrayDatos[1] = materiaDocente
            self.arrayDatos[2] = grupoDocente
            self.arrayDatos[3] = idiomaDocente
            self.arrayDatos[4] = fechaDocente
            self.arrayDatos[5] = aplicadorDocente
            
            self.arrayResultadoRubros[0] = (value?["Rubro01"] as? Int)!
            self.arrayResultadoRubros[1] = (value?["Rubro02"] as? Int)!
            self.arrayResultadoRubros[2] = (value?["Rubro03"] as? Int)!
            self.arrayResultadoRubros[3] = (value?["Rubro04"] as? Int)!
            self.arrayResultadoRubros[4] = (value?["Rubro05"] as? Int)!
            self.arrayResultadoRubros[5] = (value?["Rubro06"] as? Int)!
            self.arrayResultadoRubros[6] = (value?["Rubro07"] as? Int)!
            self.arrayResultadoRubros[7] = (value?["Rubro08"] as? Int)!
            self.arrayResultadoRubros[8] = (value?["Rubro09"] as? Int)!
            self.arrayResultadoRubros[9] = (value?["Rubro10"] as? Int)!
            self.arrayResultadoRubros[10] = (value?["Rubro11"] as? Int)!
            self.arrayResultadoRubros[11] = (value?["Rubro12"] as? Int)!
            self.arrayResultadoRubros[12] = (value?["Rubro13"] as? Int)!
            self.arrayResultadoRubros[13] = (value?["Rubro14"] as? Int)!
            self.arrayResultadoRubros[14] = (value?["Rubro15"] as? Int)!
            self.arrayResultadoRubros[15] = (value?["Rubro16"] as? Int)!
            self.arrayResultadoRubros[16] = (value?["Rubro17"] as? Int)!
            self.arrayResultadoRubros[17] = (value?["Rubro18"] as? Int)!
            self.arrayResultadoRubros[18] = (value?["Rubro19"] as? Int)!
            self.arrayResultadoRubros[19] = (value?["Rubro20"] as? Int)!
            self.arrayResultadoRubros[20] = (value?["Rubro21"] as? Int)!
            self.arrayResultadoRubros[21] = (value?["Rubro22"] as? Int)!
            self.arrayResultadoRubros[22] = (value?["Rubro23"] as? Int)!
            self.arrayResultadoRubros[23] = (value?["Rubro24"] as? Int)!
            self.arrayResultadoRubros[24] = (value?["Rubro25"] as? Int)!
            self.arrayResultadoRubros[25] = (value?["Rubro26"] as? Int)!
            self.arrayResultadoRubros[26] = (value?["Rubro27"] as? Int)!
            
            print(".................................")
            print(self.arrayResultadoRubros)
            
            print(miObservancia)
            self.lasObservaciones = miObservancia
            
            print(self.arrayDatos[0])
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                //SVProgressHUD.dismiss(withDelay: 0.5)
            }
            
        }
        
    }
    
    /*Colocar los rubros*/
    func imagenEvaluaciones(evaluacion:Int) -> UIImage{
        switch evaluacion{
        case 1:
            return UIImage(named: "iconNAY")!
        case 2:
            return UIImage(named: "iconNoY")!
        default:
            return UIImage(named: "iconYesY")!
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
            return 6
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 6
        case 4:
            return 1
        case 5:
            return 1
        case 6:
            return 2
        case 7:
            return 4
        case 8:
            return 2
        case 9:
            return 3
        default:
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            let cell01 = tableView.dequeueReusableCell(withIdentifier: "celdaDatos", for: indexPath) as! celdaResumenDatos
            cell01.labelTitulo.text = arrayTituloDatos[indexPath.row]
            cell01.labelDato.text = arrayDatos[indexPath.row]
            return cell01
        case 1:
            let cell02 = tableView.dequeueReusableCell(withIdentifier: "celdaObservaciones") as! celdaObservaciones
            cell02.labelObservaciones.text = lasObservaciones
            return cell02
        default:
            
            let cell03 = tableView.dequeueReusableCell(withIdentifier: "celdaResultados") as! celdaRubrosDetails
            
            switch indexPath.section{
                
            case 2:
                let rubroInicio = arrayEvaluacion[indexPath.row]
                let imagenInicio = arrayResultadoRubros[indexPath.row]
                cell03.imagenRubro.image = imagenEvaluaciones(evaluacion: imagenInicio)
                cell03.labelMiRubro.text = rubroInicio
                return cell03
            case 3:
                var arrayDesarrollo:[String] = []
                var imagenDesarrollo:[Int] = []
                arrayDesarrollo.append(contentsOf: arrayEvaluacion[2...7])
                imagenDesarrollo.append(contentsOf: arrayResultadoRubros[2...7])
                cell03.labelMiRubro.text = arrayDesarrollo[indexPath.row]
                cell03.imagenRubro.image = imagenEvaluaciones(evaluacion: imagenDesarrollo[indexPath.row])
                return cell03
            case 4:
                var arrayCierre:[String] = []
                var imagenCierre:[Int] = []
                arrayCierre.append(arrayEvaluacion[8])
                imagenCierre.append(arrayResultadoRubros[8])
                cell03.labelMiRubro.text = arrayCierre[indexPath.row]
                cell03.imagenRubro.image = imagenEvaluaciones(evaluacion: imagenCierre[indexPath.row])
                return cell03
            case 5:
                var arrayMultiples:[String] = []
                arrayMultiples.append(arrayEvaluacion[9])
                cell03.labelMiRubro.text = arrayMultiples[indexPath.row]
                cell03.imagenRubro.image = imagenEvaluaciones(evaluacion: arrayResultadoRubros[9])
                return cell03
            case 6:
                var arrayEmocional:[String] = []
                var imagenEmocional:[Int] = []
                arrayEmocional.append(contentsOf: arrayEvaluacion[10...11])
                imagenEmocional.append(contentsOf: arrayResultadoRubros[10...11])
                cell03.labelMiRubro.text = arrayEmocional[indexPath.row]
                cell03.imagenRubro.image = imagenEvaluaciones(evaluacion: imagenEmocional[indexPath.row])
                return cell03
            case 7:
                var arrayColaborativo:[String] = []
                var imagenColaborativo:[Int] = []
                arrayColaborativo.append(contentsOf: arrayEvaluacion[12...15])
                imagenColaborativo.append(contentsOf: arrayResultadoRubros[12...15])
                cell03.labelMiRubro.text = arrayColaborativo[indexPath.row]
                cell03.imagenRubro.image = imagenEvaluaciones(evaluacion: imagenColaborativo[indexPath.row])
                return cell03
            case 8:
                var arrayPlanificacion:[String] = []
                var imagenPlanificacion:[Int] = []
                arrayPlanificacion.append(contentsOf: arrayEvaluacion[16...17])
                imagenPlanificacion.append(contentsOf: arrayResultadoRubros[16...17])
                cell03.labelMiRubro.text = arrayPlanificacion[indexPath.row]
                cell03.imagenRubro.image = imagenEvaluaciones(evaluacion: imagenPlanificacion[indexPath.row])
                return cell03
            case 9:
                var arrayPrograma:[String] = []
                var imagenPrograma:[Int] = []
                arrayPrograma.append(contentsOf: arrayEvaluacion[18...20])
                imagenPrograma.append(contentsOf: arrayResultadoRubros[18...20])
                cell03.labelMiRubro.text = arrayPrograma[indexPath.row]
                cell03.imagenRubro.image = imagenEvaluaciones(evaluacion: imagenPrograma[indexPath.row])
                return cell03
            case 10:
                var arrayHerramientas:[String] = []
                var imagenHerramientas:[Int] = []
                arrayHerramientas.append(contentsOf: arrayEvaluacion[21...26])
                imagenHerramientas.append(contentsOf: arrayResultadoRubros[21...26])
                cell03.labelMiRubro.text = arrayHerramientas[indexPath.row]
                cell03.imagenRubro.image = imagenEvaluaciones(evaluacion: imagenHerramientas[indexPath.row])
                
            default:
                let rubroCierre = arrayEvaluacion[indexPath.row]
                let imagenDeCierre = arrayResultadoRubros[indexPath.row]
                cell03.labelMiRubro.text = rubroCierre
                cell03.imagenRubro.image = imagenEvaluaciones(evaluacion: imagenDeCierre)
                return cell03
                
            }
            
            return cell03
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
    
}
