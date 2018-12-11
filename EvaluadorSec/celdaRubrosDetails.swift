//
//  celdaRubrosDetails.swift
//  EvaluadorSec
//
//  Created by FERNANDO on 03/12/18.
//  Copyright © 2018 Fernando Vázquez Bernal. All rights reserved.
//

import UIKit

class celdaRubrosDetails: UITableViewCell {
    
    @IBOutlet weak var resultadoYes: UILabel!
    @IBOutlet weak var resultadoNo: UILabel!
    @IBOutlet weak var resultadoNoAplica: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
