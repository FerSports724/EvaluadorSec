//
//  evaluacionDetailsVC.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 07/11/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase


class evaluacionDetailsVC: UIViewController {
    
    var docenteEvaluado = String()
    var materiaSeleccionada = String()
    var claveMateria = String()
    var materiaJSON:String! = ""
    
    let headersTabla:[String] = ["INICIO DE CLASE", "DESARROLLO DE CLASE", "CIERRE DE CLASE", "INTELIGENCIAS MÚLTIPLES", "INTELIGENCIA EMOCIONAL", "APRENDIZAJE COLABORATIVO", "PLANIFICACIÓN", "PROGRAMA", "RECURSOS Y HERRAMIENTAS"]
    let cantidadCeldas:[Int] = [2, 6, 1, 1, 2, 4, 2, 3, 6]
    
    let rubros:[String] = ["Rubro01", "Rubro02", "Rubro03", "Rubro04", "Rubro05", "Rubro06", "Rubro07", "Rubro08", "Rubro09", "Rubro10", "Rubro11", "Rubro12", "Rubro13", "Rubro14", "Rubro15", "Rubro16", "Rubro17", "Rubro18", "Rubro19", "Rubro20", "Rubro21", "Rubro22", "Rubro23", "Rubro24", "Rubro25", "Rubro26", "Rubro27"]

    var arrayEvaluacion:[String] = []
    var arrayInicio:[Int] = []
    
    var arrayResultados:[Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = materiaSeleccionada
        print("+++++++++++++++++++++++++++++++")
        print(docenteEvaluado)
        print("+++++++++++++++++++++++++++++++")
        print(materiaSeleccionada)
        print("+++++++++++++++++++++++++++++++")
        print(claveMateria)
        print("+++++++++++++++++++++++++++++++")
        materiaJSON = materiaSeleccionada + "-" + claveMateria
        print(materiaJSON)
        
        jalarArray()
        otraLectura()
    }
    
    /*Jalar array del Plist*/
    func jalarArray(){
        if let URL = Bundle.main.url(forResource: "Rubros", withExtension: "plist") {
            if let miRubro = NSArray(contentsOf: URL) as? [String] {
                arrayEvaluacion = miRubro
            }
        }
    }
    
    /*Leer datos de Firebase*/
    func otraLectura(){
        let referencia = Database.database().reference().child("\(docenteEvaluado)").child("\(materiaJSON!)")
        
        referencia.observe(.value, with: { (snapshot) in
            print("*******************************")
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String:AnyObject]{
                
                var rubroEvaluar:Int
                
                for array in self.rubros{
                    rubroEvaluar = dictionary["\(array)"] as? Int ?? 0
                    self.arrayResultados.append(rubroEvaluar)
                }
                
                print(self.arrayResultados.count)
                
                for index in self.arrayResultados{
                    print("- \(index)")
                }
                
                self.arrayInicio = self.arrayResultados
                
            }else{
                print("Te crees la muy muy")
            }
            
        }, withCancel: nil)
        
        print("\(arrayInicio.count)")
        
        pruebaArray()
    }
    
    /*Función para las caritas*/
    func ponerCaritaResultado(resultado:Int) -> String{
        var nombreImagen:String! = ""
        switch resultado{
        case 0:
            nombreImagen = "iconNA"
            return nombreImagen
        case 1:
            nombreImagen = "iconYes"
            return nombreImagen
        default:
            nombreImagen = "iconNo"
            return nombreImagen
        }
    }
    
    func pruebaArray(){
        print("------------")
        print("\(arrayResultados.count)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueResumen"{
            let pantallaResumen = segue.destination as! resumenVC
            pantallaResumen.docente = docenteEvaluado
            pantallaResumen.materia = materiaJSON
        }
    }
    
    @IBAction func btnResumen(_ sender: UIBarButtonItem) {
    }

}

extension evaluacionDetailsVC:UITableViewDataSource{
    
}

extension evaluacionDetailsVC:UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headersTabla.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cantidadCeldas[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaRubro") as! celdaDetallesEvaluacion
        /*cell.imagenRubro.image = UIImage(named: "\(ponerCaritaResultado(resultado: arrayResultados[indexPath.row]))")*/
        
        switch indexPath.section {
        case 0:
            let rubroInicio = arrayEvaluacion[indexPath.row]
            cell.labelTextRubro.text = rubroInicio
        case 1:
            var arrayDesarrollo:[String] = []
            //var arrayImagenDesarrollo:[Int] = []
            arrayDesarrollo.append(contentsOf: arrayEvaluacion[2...7])
            cell.labelTextRubro.text = arrayDesarrollo[indexPath.row]
        case 2:
            var arrayCierre:[String] = []
            arrayCierre.append(arrayEvaluacion[8])
            cell.labelTextRubro.text = arrayCierre[indexPath.row]
        case 3:
            var arrayMultiples:[String] = []
            arrayMultiples.append(arrayEvaluacion[9])
            cell.labelTextRubro.text = arrayMultiples[indexPath.row]
        case 4:
            var arrayEmocional:[String] = []
            arrayEmocional.append(contentsOf: arrayEvaluacion[10...11])
            cell.labelTextRubro.text = arrayEmocional[indexPath.row]
        case 5:
            var arrayColaborativo:[String] = []
            arrayColaborativo.append(contentsOf: arrayEvaluacion[12...15])
            cell.labelTextRubro.text = arrayColaborativo[indexPath.row]
        case 6:
            var arrayPlanificacion:[String] = []
            arrayPlanificacion.append(contentsOf: arrayEvaluacion[16...17])
            cell.labelTextRubro.text = arrayPlanificacion[indexPath.row]
        case 7:
            var arrayPrograma:[String] = []
            arrayPrograma.append(contentsOf: arrayEvaluacion[18...20])
            cell.labelTextRubro.text = arrayPrograma[indexPath.row]
        case 8:
            var arrayHerramientas:[String] = []
            arrayHerramientas.append(contentsOf: arrayEvaluacion[21...26])
            cell.labelTextRubro.text = arrayHerramientas[indexPath.row]
        default:
            let rubroCierre = arrayEvaluacion[indexPath.row]
            cell.labelTextRubro.text = rubroCierre
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headersTabla[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        returnedView.backgroundColor = UIColor(red: 154/255, green: 200/255, blue: 255/255, alpha: 1.0)
        
        let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 30))
        label.text = self.headersTabla[section]
        label.textColor = .black
        label.font = UIFont(name: "Chalkboard SE", size: 30)
        returnedView.addSubview(label)
        
        return returnedView
    }
    
}
