//
//  ViewController.swift
//  AlbumGerne
//
//  Created by Spoorthy Kancharla on 1/3/20.
//  Copyright © 2020 Spoorthy Kancharla. All rights reserved.
//

import UIKit

/**
ViewController - Main ViewController. Launch ViewController.
 Download top albums from itunes
 create Tableview and display the albums in the tableviewcell
 handle tableviewcell selection
*/
class ViewController: UIViewController,UITableViewDelegate {

    let tableView = UITableView()
    var safeArea = UILayoutGuide()
    var window: UIWindow?
    var albumImages = [Dictionary<String,Any>()]
    var activityView = UIActivityIndicatorView()
    var albums = [AlbumModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //asign tableview delegate and datasource
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        tableView.allowsSelection = true

        tableView.delegate = self
        
        //create tableviewcell
        setupTableView()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        window?.rootViewController = viewController
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        //display progress dialog
        activityView = AlertController.showActivityIndicator(view: self.view)
        activityView.startAnimating()
        
        //check if device is connected to network
        if(NetworkManager.isConnectedtoNetwork()){
            //call itunes web service to get top albums
            let url = host + endpoint
            //call webservice api
            NetworkManager.fetchAlbums(urlString: url, completionHandler: { (data, error) in
                //parse response
                if let responseData = data{
                    self.parseResponse(responseData)
                    self.tableView.reloadData()
                    if(self.activityView.isAnimating){
                        self.activityView.stopAnimating()
                    }
                }else{
                    DispatchQueue.main.async {
                        AlertController.showAlert(message: "Data Issue",title: "No Data, Please try again ",vc: self,buttonText: "Close")
                        if(self.activityView.isAnimating){
                            self.activityView.stopAnimating()
                        }
                    }
                }
            })
        }else{
            DispatchQueue.main.async {
                AlertController.showAlert(message: "Network Issue",title: "No Internet, Please try connecting to internet",vc: self,buttonText: "Close")
                self.activityView.stopAnimating()
            }
        }
    }
    
    /**
     parseResponse - parsing the response returned from the webservice
    response - albums response
     */
    func parseResponse(_ response:  Dictionary<String, Any>) -> [AlbumModel]{
        //clear the diuctionary if it has any values in it
        albums.removeAll()
        //exract album values and add it to the library
        if let appJson = response["feed"] as? Dictionary<String, Any> {
            if let resultArray = appJson["results"] as? [Dictionary<String,Any>]{
                for album in resultArray{
                     //parsing album data to dictionary
                     let albumValues = AlbumModel(album)
                     albums.append(albumValues)
                }
            }
        }
        return albums
    }
    
    /**
     setupTableView - create tableviewcell
     */
    func setupTableView() {
      view.addSubview(tableView)
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumCell")
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

/**
 handle TableViewDataSource - create tableview cells with album image title and artist name
 handle selection of tableviewcell
 */
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albums.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumTableViewCell{
        let album = albums[indexPath.row]
        
        cell.albumNameLabel.text = album.name
        cell.albumArtistNameLabel.text = album.artistName
        
         let url = album.artworkUrl
            if let imageUrl = URL(string: url){
                DispatchQueue.main.async {
                    Utilities().downloadImage(from: imageUrl,completionHandler: { (data, error) in
                        DispatchQueue.main.async {
                            if let imageData = data{
                                cell.albumImageView.image = UIImage(data: imageData)
                            }
                        }
                    })
                }
            }
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }else{
        return UITableViewCell()
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
      let selectedAlubm = albums[indexPath.row]
      let vc = AlbumDetailsViewController()
      vc.albumDetails = selectedAlubm
      let navigation = UINavigationController(rootViewController: vc)
      self.present(navigation, animated: true, completion: nil)
  }
    
}

