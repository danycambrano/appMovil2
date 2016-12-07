//
//  UIImageView.swift
//  AppDemo
//
//  Created by ADMINISTRADORUTM on 07/12/16.
//  Copyright © 2016 tecrios. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadPicture(url: String)
    {
    if url.characters.count < 7
    {
    return
    }
    do {
    let dato = try Data (contentsOf: URL(string: url)!)
    self.image = UIImage(data: dato)
    
    } catch {
    print ("Error: \(error)")
}
}
}
