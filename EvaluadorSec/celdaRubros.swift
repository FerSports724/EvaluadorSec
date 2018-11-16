//
//  celdaRubros.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 15/11/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit

class celdaRubros: UITableViewCell {
    
    @IBOutlet var labelRubro: UILabel!
    @IBOutlet var btnYes: UIButton!
    @IBOutlet var btnNo: UIButton!
    @IBOutlet var btnNA: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
