//
//  nuevaEvaluacionVC.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 29/10/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit
import FirebaseAuth

class nuevaEvaluacionVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnIniciar: UIButton!
    @IBOutlet var btnCancelar: UIButton!
    @IBOutlet var viewDatos: UIView!
    
    var docenteEvaluar = String()
    var evaluador = String()
    var fecha:String = ""
    var evaluadorRegistrado:Bool = true
    
    let arrayPlaceHolder:[String] = ["Docente", "Fecha", "Idioma", "Grado y grupo", "Materia", "Implementador"]
    let arrayImages:[String] = ["iconUser", "iconDate", "iconLanguage", "iconGroup", "iconSubject", "iconEvaluator"]
    
    var arrayDatos:[String] = []
    var arrayTextField = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDatos.layer.cornerRadius = 10
        print("Mai: \(docenteEvaluar)")
        definirFecha()
        definirEvaluador()
    }
    
    func definirFecha(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MM-yyyy"
        fecha = formatter.string(from: yourDate!)
        
        print(fecha)
    }
    
    func definirEvaluador(){
        let elEvaluador = String(describing: Auth.auth().currentUser!.uid)
        
        print("Hola: soy el evaluador: \(elEvaluador)")
        
        switch elEvaluador {
        case "YUwhmKYIZlhxXTsgOLrzgVAm1002":
            evaluador = "Marcos López Aquino"
            evaluadorRegistrado = true
        case "fUcxuVmfTTYCqQaOZPM4ERTOt7v2":
            evaluador = "Diana Vázquez Fosado"
            evaluadorRegistrado = true
        default:
            evaluador = ""
            evaluadorRegistrado = false
        }
    }
    
    @IBAction func iniciarEvaluacion(_ sender: UIButton) {
        let arrayIndex:[Int] = [0, 1, 2, 3, 4, 5]
        arrayDatos = []
        var dato:String = ""
        for myIndice in arrayIndex{
            let elIndex = IndexPath(row: myIndice, section: 0)
            let laCelda = self.tableView.cellForRow(at: elIndex) as! celdaDatos
            if laCelda.textFieldFila.text != ""{
                dato = laCelda.textFieldFila.text!
                print(dato)
                arrayDatos.append(dato)
            }else{
                let alert = UIAlertController(title: "Faltan Datos", message: "Faltan datos por colocar", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                arrayDatos = []
            }
        }
        
        print(arrayDatos.count)
    }
    
    @IBAction func cancelar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func jalarDatos(){
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaDatos") as! celdaDatos
        for index in 0...arrayPlaceHolder.count{
            if cell.textFieldFila.text != ""{
                arrayDatos[index] = cell.textFieldFila.text!
            }
        }
        print("------+++++++---------")
        print(arrayDatos.count)
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
        
        switch indexPath.row{
        case 0:
            cell.textFieldFila.text = docenteEvaluar
            cell.textFieldFila.isEnabled = false
            cell.isUserInteractionEnabled = false
        case 1:
            cell.textFieldFila.text = fecha
            cell.textFieldFila.isEnabled = false
        case 5:
            if evaluadorRegistrado{
                cell.textFieldFila.text = evaluador
                cell.textFieldFila.isEnabled = false
            }
            cell.textFieldFila.placeholder = placeholderText
        default:
            cell.textFieldFila.placeholder = placeholderText
        }
        
        cell.iconoFila.image = UIImage(named: imageIcon)
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueNuevaEv"{
            let pantallaDos = segue.destination as! iniciarEvaluacion
            pantallaDos.arrayQuellega = arrayDatos
        }
    }
}
