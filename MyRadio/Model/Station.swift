//
//  Station.swift
//  MyRadio
//
//  Created by Андрей Бородин on 24.07.2018.
//  Copyright © 2018 Sid. All rights reserved.
//

import Foundation
import UIKit


struct Station:Codable {
    let name: String
    let url: URL
    var imageUrl: URL
    
    init (name: String, url: URL, image: URL) {
        self.name = name
        self.url = url
        self.imageUrl = image
    }
}
