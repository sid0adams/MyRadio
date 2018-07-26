//
//  track.swift
//  MyRadio
//
//  Created by Андрей Бородин on 24.07.2018.
//  Copyright © 2018 Sid. All rights reserved.
//
import UIKit

struct Track {
    var title: String
    var artist: String
    var artworkImage: UIImage?
    var artworkLoaded = false
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}
