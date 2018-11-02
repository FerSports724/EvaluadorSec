//
//  ViewController.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 22/10/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import SVProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil{
            self.performSegue(withIdentifier: "showMainMenu", sender: self)
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        guard email.text != nil else {
            return
        }
        
        guard password != nil else {
            return
        }
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error != nil{
                SVProgressHUD.dismiss()
                let alerta = UIAlertController(title: "Error", message: "Datos incorrectos.", preferredStyle: UIAlertController.Style.alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alerta, animated: true, completion: nil)
                print(error!)
            }else{
                self.performSegue(withIdentifier: "showMainMenu", sender: self)
                SVProgressHUD.dismiss()
                print("-------------------------------")
                print("Nos hemos logueado, ¡¡yeeeeey!!")
            }
        }
        
    }
    
    
    
}

