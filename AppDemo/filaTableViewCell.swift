//
//  filaTableViewCell.swift
//  AppDemo
//
//  Created by ADMINISTRADORUTM on 05/12/16.
//  Copyright © 2016 tecrios. All rights reserved.
//

import UIKit

class filaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblIzquierda: UILabel!
    
    @IBOutlet weak var lblNom: UILabel!
    @IBOutlet weak var lblDerecha: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
