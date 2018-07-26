//
//  FileWork.swift
//  MyRadio
//
//  Created by Андрей Бородин on 25.07.2018.
//  Copyright © 2018 Sid. All rights reserved.
//

import Foundation


struct FileWork {
    
    static func getDataWithSuccess(success: (_ data: [Station]?) -> Void) {
        guard let filePathURL = Bundle.main.url(forResource: "stations", withExtension: "json") else {
            success(nil)
            return
        }
        
        do {
            let data = try Data(contentsOf: filePathURL, options: .uncached)
            let decoder = JSONDecoder()
            let stations :[Station]
            stations  = try! decoder.decode([Station].self, from: data)
            success(stations)
        } catch {
            fatalError()
        }
    }
    static func setData(stations: [Station])
    {
        guard let filePathURL = Bundle.main.url(forResource: "stations", withExtension: "json") else {
            return
        }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(stations)
        try! data.write(to: filePathURL)
    }
    
    
}
