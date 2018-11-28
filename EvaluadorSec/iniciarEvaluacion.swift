//
//  iniciarEvaluacion.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 14/11/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit

class iniciarEvaluacion: UIViewController {
    
    var arrayQuellega:[String] = []
    var arrayEvaluacion:[String] = []
    
    @IBOutlet var tableView: UITableView!

    let headersTabla:[String] = ["INICIO DE CLASE", "DESARROLLO DE CLASE", "CIERRE DE CLASE", "INTELIGENCIAS MÚLTIPLES", "INTELIGENCIA EMOCIONAL", "APRENDIZAJE COLABORATIVO", "PLANIFICACIÓN", "PROGRAMA", "RECURSOS Y HERRAMIENTAS"]
    let cantidadCeldas:[Int] = [2, 6, 1, 1, 2, 4, 2, 3, 6]
    
    var inicio:[Int] = [1, 1]
    var desarrollo:[Int] = [1, 1, 1, 1, 1, 1]
    var cierre:Int = 1
    var multiples:Int = 1
    var emocional:[Int] = [1, 1]
    var colaborativo:[Int] = [1, 1, 1, 1]
    var planificacion:[Int] = [1, 1]
    var programa:[Int] = [1, 1, 1]
    var recursos:[Int] = [1, 1, 1, 1, 1, 1]
    
    var arrayGeneralDatos:[Int] = []
    
    var misObservaciones:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print(arrayQuellega.count)
        jalarArray()
    }
    
    /*Jalar array del Plist*/
    func jalarArray(){
        if let URL = Bundle.main.url(forResource: "Rubros", withExtension: "plist") {
            if let miRubro = NSArray(contentsOf: URL) as? [String] {
                arrayEvaluacion = miRubro
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /*Salir*/
    @IBAction func dismissBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*Guardar datos*/
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        arrayGeneralDatos = inicio + desarrollo
        print("ññññññññññññññññññññ")
        print(arrayGeneralDatos)
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    /*Observaciones*/
    @IBAction func observacionesBtn(_ sender: UIBarButtonItem) {
    }
    
    /*Segue*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueObservaciones"{
            let obsVC = segue.destination as! observacionesViewController
            obsVC.observacionQueLlega = misObservaciones
            obsVC.maestroQueLlega = arrayQuellega[0]
            obsVC.fechaQueLlega = arrayQuellega[1]

            obsVC.onSave = onSave
        }
    }
    
    /*Función onSave*/
    func onSave(_ data: String) -> (){
        misObservaciones = data
    }
    
    
}

extension iniciarEvaluacion: UITableViewDataSource{
    
}

extension iniciarEvaluacion: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return headersTabla.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cantidadCeldas[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaEvaluar", for: indexPath) as! celdaRubros
        
        cell.btnYes.imageView?.image = UIImage(named: "iconYes")
        cell.btnNo.imageView?.image = UIImage(named: "iconNo")
        cell.btnNA.imageView?.image = UIImage(named: "iconNA")
        
        cell.cellDelegate = self
        cell.index = indexPath
        cell.seccion = indexPath.section
        
        switch indexPath.section {
        case 0:
            let rubroInicio = arrayEvaluacion[indexPath.row]
            cell.labelRubro.text = rubroInicio
        case 1:
            var arrayDesarrollo:[String] = []
            //var arrayImagenDesarrollo:[Int] = []
            arrayDesarrollo.append(contentsOf: arrayEvaluacion[2...7])
            cell.labelRubro.text = arrayDesarrollo[indexPath.row]
        case 2:
            var arrayCierre:[String] = []
            arrayCierre.append(arrayEvaluacion[8])
            cell.labelRubro.text = arrayCierre[indexPath.row]
        case 3:
            var arrayMultiples:[String] = []
            arrayMultiples.append(arrayEvaluacion[9])
            cell.labelRubro.text = arrayMultiples[indexPath.row]
        case 4:
            var arrayEmocional:[String] = []
            arrayEmocional.append(contentsOf: arrayEvaluacion[10...11])
            cell.labelRubro.text = arrayEmocional[indexPath.row]
        case 5:
            var arrayColaborativo:[String] = []
            arrayColaborativo.append(contentsOf: arrayEvaluacion[12...15])
            cell.labelRubro.text = arrayColaborativo[indexPath.row]
        case 6:
            var arrayPlanificacion:[String] = []
            arrayPlanificacion.append(contentsOf: arrayEvaluacion[16...17])
            cell.labelRubro.text = arrayPlanificacion[indexPath.row]
        case 7:
            var arrayPrograma:[String] = []
            arrayPrograma.append(contentsOf: arrayEvaluacion[18...20])
            cell.labelRubro.text = arrayPrograma[indexPath.row]
        case 8:
            var arrayHerramientas:[String] = []
            arrayHerramientas.append(contentsOf: arrayEvaluacion[21...26])
            cell.labelRubro.text = arrayHerramientas[indexPath.row]
        default:
            let rubroCierre = arrayEvaluacion[indexPath.row]
            cell.labelRubro.text = rubroCierre
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

extension iniciarEvaluacion: celdaPresionadaBoton{
    @objc func onClick(seccion: Int, index: Int, tag: Int) {
        print("Sección: \(seccion)")
        print("Index: \(index)")
        print("Tag: \(tag)")
        
        /*switch seccion {
        case 0:
            inicio[index] = tag
            print("..........")
            print(inicio)
        case 1:
            desarrollo[index] = tag
            print("..........")
            print(desarrollo)
        case 2:
            cierre = tag
            print("..........")
            print(cierre)
        case 3:
            multiples = tag
            print("..........")
            print(multiples)
        case 4:
            emocional[index] = tag
            print("..........")
            print(emocional)
        case 5:
            colaborativo[index] = tag
            print("..........")
            print(colaborativo)
        case 6:
            planificacion[index] = tag
            print("..........")
            print(planificacion)
        case 7:
            programa[index] = tag
            print("..........")
            print(programa)
        case 8:
            recursos[index] = tag
            print("..........")
            print(recursos)
        default:
            print("..........")
            print("Mis ataques komodos de dinero.")
        }*/
        
    }
}
