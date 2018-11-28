//
//  observacionesViewController.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 28/11/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class observacionesViewController: UIViewController {
    
    @IBOutlet weak var observacionesMarcos: UITextView!
    @IBOutlet weak var observacionesDiana: UITextView!
    @IBOutlet weak var observacionesOtro: UITextView!
    
    var observacionQueLlega = String()
    var maestroQueLlega = String()
    var fechaQueLlega = String()
    
    var maestroEvaluador:String = ""
    var docente:String = ""
    
    var onSave: ((_ data: String) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        docente = maestroQueLlega + " " + fechaQueLlega
        seleccionarEvaluador().text = observacionQueLlega
        descargarDatosFirebase()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    /*Seleccionar el maestro que llegue*/
    func seleccionarEvaluador() -> UITextView{
        let maiUser = Auth.auth().currentUser?.uid
        
        switch maiUser {
        case "fUcxuVmfTTYCqQaOZPM4ERTOt7v2":
            maestroEvaluador = "Diana"
            observacionesMarcos.isEditable = false
            observacionesOtro.isEditable = false
            return observacionesDiana
        case "YUwhmKYIZlhxXTsgOLrzgVAm1002":
            maestroEvaluador = "Marcos"
            observacionesDiana.isEditable = false
            observacionesOtro.isEditable = false
            return observacionesMarcos
        default:
            maestroEvaluador = "Otro"
            observacionesDiana.isEditable = false
            observacionesMarcos.isEditable = false
            return observacionesOtro
        }
    }
    
    @IBAction func btnCerrar(_ sender: UIButton) {
        guardarDatos()
        onSave?(seleccionarEvaluador().text)
        self.dismiss(animated: true, completion: nil)
    }
    
    func guardarDatos(){
        let myRef = Database.database().reference().child("Observaciones").child("\(docente)").child("\(maestroEvaluador)")
        myRef.setValue(["Comentario" : seleccionarEvaluador().text])
    }
    
    func descargaDatosDiana(){
        _ = Database.database().reference().child("Observaciones").child("\(docente)").child("Diana").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let mensaje = value?["Comentario"] as? String
            self.observacionesDiana.text = mensaje
            
        }
    }
    
    func descargaDatosMarcos(){
        _ = Database.database().reference().child("Observaciones").child("\(docente)").child("Marcos").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let mensaje = value?["Comentario"] as? String
            self.observacionesMarcos.text = mensaje
            
        }
    }
    
    func descargaDatosOtro(){
        _ = Database.database().reference().child("Observaciones").child("\(docente)").child("Otro").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let mensaje = value?["Comentario"] as? String
            self.observacionesOtro.text = mensaje
            
        }
    }
    
    func descargarDatosFirebase(){
        
        switch maestroEvaluador {
        case "Diana":
            descargaDatosMarcos()
            descargaDatosOtro()
        case "Marcos":
            descargaDatosDiana()
            descargaDatosOtro()
        default:
            descargaDatosDiana()
            descargaDatosMarcos()
        }
        
    }

}
