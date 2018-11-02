//
//  MainMenuView.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 22/10/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class MainMenuView: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var arrayMaestros:[modeloMaestro] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("*_* *_* *_* *_* *_* *_* *_* *_* *_* *_*")
        print("\(String(describing: Auth.auth().currentUser?.uid))")
        armaldoArreglo()
        
        /*Aquí configuramos el espaciado*/
        let itemSize = UIScreen.main.bounds.width/3 - 2
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        collectionView.collectionViewLayout = layout
    }
    
    /*Jalar datos de Plist*/
    func armaldoArreglo(){
        let path = Bundle.main.path(forResource: "Docentes", ofType: "plist")! as String
        let url = URL(fileURLWithPath: path)
        
        do{
            let data = try Data(contentsOf: url)
            let plist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
            let dicArray = plist as! [[String:String]]
            for inicio in dicArray{
                arrayMaestros.append(modeloMaestro(nombre: inicio["Nombre"]!, identificador: inicio["Identificador"]!, idioma: inicio["Idioma"]!, imagen: inicio["Imagen"]!))
            }
        }catch{
            print("No podemos acceder al archivo.")
        }
    }
    
    /*Botón para cerrar sesión*/
    @IBAction func logout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }catch{
            print("Error: nose ha podido desloguear.")
        }
        
        guard navigationController?.popToRootViewController(animated: true) != nil else{
            print("No hay View Controllers que eliminar de la pila.")
            return
        }
    }
    
}

extension MainMenuView: UICollectionViewDataSource{
    
}

extension MainMenuView: UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayMaestros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let maestro = arrayMaestros[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDocente", for: indexPath) as! celdaDocente
        cell.imagenMaestro.image = UIImage(named: maestro.imagen)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let maestro = arrayMaestros[indexPath.row]
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: "evaluacionesVC") as! EvaluacionesTableVC
        destinationVC.idDocente = indexPath.row
        destinationVC.docenteSeleccionad = maestro.nombre
        navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
}
