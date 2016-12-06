//
//  detalleViewController.swift
//  AppDemo
//
//  Created by ADMINISTRADORUTM on 06/12/16.
//  Copyright © 2016 tecrios. All rights reserved.
//

import UIKit

protocol detalleViewControllerDelegate{
    func numeroCambiado(numero: Int)
}

class detalleViewController: UIViewController {
    
        // MARK: Declaraciones
    var numeroFila = -1
    var dato: String = ""
    var datoNumero: Int = 0
    
    var delegado : detalleViewControllerDelegate? = nil
    
    @IBOutlet weak var lblBoton1: UILabel!
        // MARK: Metodos

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblBoton1.text = "Haz elegido \(dato) y tiene \(datoNumero) años"
        
     //   lblBoton1.text = "\(numeroFila)"
        
        if delegado != nil
        {
            delegado?.numeroCambiado(numero: numeroFila)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
