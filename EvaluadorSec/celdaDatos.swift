//
//  celdaDatos.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 29/10/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit

class celdaDatos: UITableViewCell {
    
    @IBOutlet var iconoFila: UIImageView!
    @IBOutlet var textFieldFila: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
