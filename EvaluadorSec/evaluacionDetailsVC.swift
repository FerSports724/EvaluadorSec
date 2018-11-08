//
//  evaluacionDetailsVC.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 07/11/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit

class evaluacionDetailsVC: UIViewController {
    
    var docenteEvaluado = String()
    var materiaSeleccionada = String()
    var claveMateria = String()
    var materiaJSON:String! = ""
    
    let headersTabla:[String] = ["INICIO DE CLASE", "DESARROLLO DE CLASE", "CIERRE DE CLASE", "INTELIGENCIAS MÚLTIPLES", "INTELIGENCIA EMOCIONAL", "APRENDIZAJE COLABORATIVO", "PLANIFICACIÓN", "PROGRAMA", "RECURSOS Y HERRAMIENTAS"]
    let cantidadCeldas:[Int] = [2, 6, 1, 1, 2, 4, 2, 3, 6]

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaRubro")
        return cell!
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
