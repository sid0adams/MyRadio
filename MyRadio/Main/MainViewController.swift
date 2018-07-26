//
//  MainViewController.swift
//  MyRadio
//
//  Created by Андрей Бородин on 26.07.2018.
//  Copyright © 2018 Sid. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    fileprivate struct Constants {
        static let customCellIdentifier = "customCell"
    }
    
    let player: FRadioPlayer = FRadioPlayer.shared
    var stations = [Station]() {
        didSet {
            //stationUpdate()
        }
    }
    var selectedStation = -1
    
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var StationsTable: UITableView!
    
    @IBOutlet weak var BarImage: UIImageView!
    @IBOutlet weak var BarLabel: UILabel!
    @IBOutlet weak var PlayBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.delegate = self
        //player.radioURL = URL(string: "http://rfcmedia.streamguys1.com/Newport.mp3")!
        
        loadStation()
        configureTable()
        
        BarImage.contentMode = .scaleAspectFit
    }
    
    func loadStation() {
        FileWork.getDataWithSuccess() { (stations) in
            self.stations = stations!
        }
    }
    func setPlay(index: Int) {
        if selectedStation != index % stations.count {
            selectedStation = index % stations.count
            BarLabel.text = "Загрузка"
            DispatchQueue.main.async {
                self.player.radioURL = self.stations[self.selectedStation].url
            }
        }
    }
    func setBar() {
        ImageLoader.sharedLoader.imageForUrl(urlString: stations[selectedStation].imageUrl.absoluteString, completionHandler: {(image: UIImage?, url: String) in
            DispatchQueue.main.async {
                self.BarImage.image = image
            }})
        BarLabel.text = stations[selectedStation].name
    }
    
    @IBAction func PreviousAction() {
        setPlay(index: selectedStation - 1 + stations.count)
    }
    
    @IBAction func NextAction() {
        setPlay(index: selectedStation + 1)
    }
    
    
}
private extension MainViewController {
    
    func configureTable(){
        StationsTable.separatorStyle = .none
        StationsTable.delegate = self
        StationsTable.dataSource = self
        StationsTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: Constants.customCellIdentifier)
    }
}

extension MainViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let Cell = StationsTable.dequeueReusableCell(withIdentifier: Constants.customCellIdentifier) as? TableViewCell
            else {
                return UITableViewCell();
        }
        Cell.Configure(station: stations[indexPath.row ])
        return Cell
    }
    
    
}
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        StationsTable.deselectRow(at: indexPath, animated: true)
        setPlay(index: indexPath.row)
    }
    
}
extension MainViewController :FRadioPlayerDelegate{
    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        switch state {
        case .loadingFinished:
            player.togglePlaying()
            setBar()
            return
        case .error:
            errorBar()
            return
        default:
            return
        }
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        
    }
    
    
}
