//
//  TableViewCell.swift
//  MyRadio
//
//  Created by Андрей Бородин on 26.07.2018.
//  Copyright © 2018 Sid. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var RadioImage: UIImageView!
    @IBOutlet weak var RadioName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func Configure(station: Station) {
        RadioName.text = station.name
        RadioImage.clipsToBounds = true
        RadioImage.contentMode = .scaleAspectFit
        
        ImageLoader.sharedLoader.imageForUrl(urlString: station.imageUrl.absoluteString, completionHandler:{(image: UIImage?, url: String) in
            DispatchQueue.main.async {
                self.RadioImage.image = image
            }
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
