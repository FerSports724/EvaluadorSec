//
//  iniciarEvaluacion.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 14/11/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class iniciarEvaluacion: UIViewController {
    
    var arrayQuellega:[String] = []
    var arrayEvaluacion:[String] = []
    
    @IBOutlet var tableView: UITableView!

    let headersTabla:[String] = ["INICIO DE CLASE", "DESARROLLO DE CLASE", "CIERRE DE CLASE", "INTELIGENCIAS MÚLTIPLES", "INTELIGENCIA EMOCIONAL", "APRENDIZAJE COLABORATIVO", "PLANIFICACIÓN", "PROGRAMA", "RECURSOS Y HERRAMIENTAS"]
    let cantidadCeldas:[Int] = [2, 6, 1, 1, 2, 4, 2, 3, 6]
    
    let rubrosFirebase:[String] = ["Clave", "Docente", "Fecha", "Idioma", "Grupo", "Materia", "Implementador", "ID-Evaluador", "Observaciones", "Rubro01", "Rubro02", "Rubro03", "Rubro04", "Rubro05", "Rubro06", "Rubro07", "Rubro08", "Rubro09", "Rubro10", "Rubro11", "Rubro12", "Rubro13", "Rubro14", "Rubro15", "Rubro16", "Rubro17", "Rubro18", "Rubro19", "Rubro20", "Rubro21", "Rubro22", "Rubro23", "Rubro24", "Rubro25", "Rubro26", "Rubro27"]
    
    var inicio:[Int] = [1, 1]
    var desarrollo:[Int] = [1, 1, 1, 1, 1, 1]
    var cierre:Int = 1
    var multiples:Int = 1
    var emocional:[Int] = [1, 1]
    var colaborativo:[Int] = [1, 1, 1, 1]
    var planificacion:[Int] = [1, 1]
    var programa:[Int] = [1, 1, 1]
    var recursos:[Int] = [1, 1, 1, 1, 1, 1]
    
    var arrayImagenInicio:[Int] = [0, 0]
    var arrayImagenDesarrollo:[Int] = [0, 0, 0, 0, 0, 0]
    var arrayImagenCierre:Int = 0
    var arrayImagenMultiples:Int = 0
    var arrayImagenEmocional:[Int] = [0, 0]
    var arrayImagenColaborativo:[Int] = [0, 0, 0, 0]
    var arrayImagenPlanificacion:[Int] = [0, 0]
    var arrayImagenPrograma:[Int] = [0, 0, 0]
    var arrayImagenRecursos:[Int] = [0, 0, 0, 0, 0, 0]
    
    var arrayResultadosRubros:[Int] = []
    var generalArray:[Any] = []
    
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
        generalArray = []
        arrayResultadosRubros = []
        
        let idDelEvaluador = Auth.auth().currentUser?.uid
        let claveMateria = randomString(length: 8)
        let materiaGuardar = arrayQuellega[4] + "-" + claveMateria
        print(materiaGuardar)
        
        arrayResultadosRubros = inicio + desarrollo
        arrayResultadosRubros.append(cierre)
        arrayResultadosRubros.append(multiples)
        arrayResultadosRubros = arrayResultadosRubros + emocional + colaborativo + planificacion + programa + recursos
        
        generalArray.append(claveMateria)
        generalArray = generalArray + arrayQuellega
        generalArray.append(idDelEvaluador!)
        generalArray.append(misObservaciones)
        generalArray = generalArray + arrayResultadosRubros

        let myRef = Database.database().reference()
        
        for index in 0...generalArray.count-1{
            
            print("Clave: \(rubrosFirebase[index]). Valor: \(generalArray[index])")
            
            myRef.child("\(arrayQuellega[0])/\(materiaGuardar)/\(rubrosFirebase[index])").setValue(generalArray[index])
            print("---------------")
            print("Se ha añadido un elemento a Firebase")
            
        }

        
        print(generalArray.count)
        
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
    
    /*Generar Identificador aleatorio*/
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
    /*Establecer imagen*/
    func establecerImagen(elIndex:Int) -> (happy: UIImage, sad: UIImage, nel: UIImage){
        var imagenHappy:UIImage
        var imagenSad:UIImage
        var imagenNel:UIImage
        
        switch elIndex {
        case 3:
            imagenHappy = UIImage(named: "iconYesY")!
            imagenSad = UIImage(named: "iconNoWhite")!
            imagenNel = UIImage(named: "iconNAWhite")!
            
            return (imagenHappy, imagenSad, imagenNel)
            
        case 2:
            imagenHappy = UIImage(named: "iconYesWhite")!
            imagenSad = UIImage(named: "iconNoY")!
            imagenNel = UIImage(named: "iconNAWhite")!
            
            return (imagenHappy, imagenSad, imagenNel)
            
        case 1:
            imagenHappy = UIImage(named: "iconYesWhite")!
            imagenSad = UIImage(named: "iconNoWhite")!
            imagenNel = UIImage(named: "iconNAY")!
            
            return (imagenHappy, imagenSad, imagenNel)
            
        default:
            imagenHappy = UIImage(named: "iconYesY")!
            imagenSad = UIImage(named: "iconNoY")!
            imagenNel = UIImage(named: "iconNAY")!
            
            return (imagenHappy, imagenSad, imagenNel)
        }
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
        
        cell.cellDelegate = self
        cell.index = indexPath
        cell.seccion = indexPath.section
        
        switch indexPath.section {
        case 0:
            let rubroInicio = arrayEvaluacion[indexPath.row]
            let miImagen = establecerImagen(elIndex: arrayImagenInicio[indexPath.row])
            cell.btnYes.imageView?.image = miImagen.happy
            cell.btnNo.imageView?.image = miImagen.sad
            cell.btnNA.imageView?.image = miImagen.nel
            cell.labelRubro.text = rubroInicio
        case 1:
            var arrayDesarrollo:[String] = []
            let miImagen = establecerImagen(elIndex: arrayImagenDesarrollo[indexPath.row])
            arrayDesarrollo.append(contentsOf: arrayEvaluacion[2...7])
            cell.btnYes.imageView?.image = miImagen.happy
            cell.btnNo.imageView?.image = miImagen.sad
            cell.btnNA.imageView?.image = miImagen.nel
            cell.labelRubro.text = arrayDesarrollo[indexPath.row]
        case 2:
            var arrayCierre:[String] = []
            arrayCierre.append(arrayEvaluacion[8])
            let miImagen = establecerImagen(elIndex: arrayImagenCierre)
            cell.btnYes.imageView?.image = miImagen.happy
            cell.btnNo.imageView?.image = miImagen.sad
            cell.btnNA.imageView?.image = miImagen.nel
            cell.labelRubro.text = arrayCierre[indexPath.row]
        case 3:
            var arrayMultiples:[String] = []
            arrayMultiples.append(arrayEvaluacion[9])
            let miImagen = establecerImagen(elIndex: arrayImagenMultiples)
            cell.btnYes.imageView?.image = miImagen.happy
            cell.btnNo.imageView?.image = miImagen.sad
            cell.btnNA.imageView?.image = miImagen.nel
            cell.labelRubro.text = arrayMultiples[indexPath.row]
        case 4:
            var arrayEmocional:[String] = []
            arrayEmocional.append(contentsOf: arrayEvaluacion[10...11])
            let miImagen = establecerImagen(elIndex: arrayImagenEmocional[indexPath.row])
            cell.btnYes.imageView?.image = miImagen.happy
            cell.btnNo.imageView?.image = miImagen.sad
            cell.btnNA.imageView?.image = miImagen.nel
            cell.labelRubro.text = arrayEmocional[indexPath.row]
        case 5:
            var arrayColaborativo:[String] = []
            arrayColaborativo.append(contentsOf: arrayEvaluacion[12...15])
            let miImagen = establecerImagen(elIndex: arrayImagenColaborativo[indexPath.row])
            cell.btnYes.imageView?.image = miImagen.happy
            cell.btnNo.imageView?.image = miImagen.sad
            cell.btnNA.imageView?.image = miImagen.nel
            cell.labelRubro.text = arrayColaborativo[indexPath.row]
        case 6:
            var arrayPlanificacion:[String] = []
            arrayPlanificacion.append(contentsOf: arrayEvaluacion[16...17])
            let miImagen = establecerImagen(elIndex: arrayImagenPlanificacion[indexPath.row])
            cell.btnYes.imageView?.image = miImagen.happy
            cell.btnNo.imageView?.image = miImagen.sad
            cell.btnNA.imageView?.image = miImagen.nel
            cell.labelRubro.text = arrayPlanificacion[indexPath.row]
        case 7:
            var arrayPrograma:[String] = []
            arrayPrograma.append(contentsOf: arrayEvaluacion[18...20])
            let miImagen = establecerImagen(elIndex: arrayImagenPrograma[indexPath.row])
            cell.btnYes.imageView?.image = miImagen.happy
            cell.btnNo.imageView?.image = miImagen.sad
            cell.btnNA.imageView?.image = miImagen.nel
            cell.labelRubro.text = arrayPrograma[indexPath.row]
        case 8:
            var arrayHerramientas:[String] = []
            arrayHerramientas.append(contentsOf: arrayEvaluacion[21...26])
            let miImagen = establecerImagen(elIndex: arrayImagenRecursos[indexPath.row])
            cell.btnYes.imageView?.image = miImagen.happy
            cell.btnNo.imageView?.image = miImagen.sad
            cell.btnNA.imageView?.image = miImagen.nel
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
        
        switch seccion {
        case 0:
            inicio[index] = tag
            arrayImagenInicio[index] = tag
            print("..........")
            print(inicio)
        case 1:
            desarrollo[index] = tag
            arrayImagenDesarrollo[index] = tag
            print("..........")
            print(desarrollo)
        case 2:
            cierre = tag
            arrayImagenCierre = tag
            print("..........")
            print(cierre)
        case 3:
            multiples = tag
            arrayImagenMultiples = tag
            print("..........")
            print(multiples)
        case 4:
            emocional[index] = tag
            arrayImagenEmocional[index] = tag
            print("..........")
            print(emocional)
        case 5:
            colaborativo[index] = tag
            arrayImagenColaborativo[index] = tag
            print("..........")
            print(colaborativo)
        case 6:
            planificacion[index] = tag
            arrayImagenPlanificacion[index] = tag
            print("..........")
            print(planificacion)
        case 7:
            programa[index] = tag
            arrayImagenPrograma[index] = tag
            print("..........")
            print(programa)
        case 8:
            recursos[index] = tag
            arrayImagenRecursos[index] = tag
            print("..........")
            print(recursos)
        default:
            print("..........")
            print("Mis ataques komodos de dinero.")
        }
        
    }
}
