//
//  celdaRubros.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 15/11/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit

protocol celdaPresionadaBoton {
    func onClick(seccion: Int, index: Int, tag:Int)
}

class celdaRubros: UITableViewCell {
    
    @IBOutlet var labelRubro: UILabel!
    @IBOutlet var btnYes: UIButton!
    @IBOutlet var btnNo: UIButton!
    @IBOutlet var btnNA: UIButton!
    
    var cellDelegate:celdaPresionadaBoton?
    var index:IndexPath?
    var seccion:Int?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /*override func prepareForReuse() {
        
    }*/
    
    /*override func prepareForReuse() {
        btnYes.imageView?.image = UIImage(named: "iconYesY")
        btnNo.imageView?.image = UIImage(named: "iconNoY")
        btnNA.imageView?.image = UIImage(named: "iconNAY")
    }*/
    
    @IBAction func btnPressed(_ sender: UIButton) {
        cellDelegate?.onClick(seccion: seccion!, index: (index?.row)!, tag: sender.tag)
        
        switch sender.tag {
            case 3:
                btnYes.imageView?.image = UIImage(named: "iconYesY")
                btnNo.imageView?.image = UIImage(named: "iconNoWhite")
                btnNA.imageView?.image = UIImage(named: "iconNAWhite")
            case 2:
                btnYes.imageView?.image = UIImage(named: "iconYesWhite")
                btnNo.imageView?.image = UIImage(named: "iconNoY")
                btnNA.imageView?.image = UIImage(named: "iconNAWhite")
            case 1:
                btnYes.imageView?.image = UIImage(named: "iconYesWhite")
                btnNo.imageView?.image = UIImage(named: "iconNoWhite")
                btnNA.imageView?.image = UIImage(named: "iconNAY")
            default:
                print("Popolvuh")
        }
    }
    
}
