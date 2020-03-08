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
class ViewController: UIViewController,UITableViewDelegate,AlbumErrorDelegate {

    let tableView = UITableView()
    var safeArea = UILayoutGuide()
    
    var albumImages = [Dictionary<String,Any>()]
    var activityView = UIActivityIndicatorView()
    
    var errorDelegate :AlbumErrorDelegate?
    
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //asign tableview delegate and datasource
        view.backgroundColor = .white
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        tableView.allowsSelection = true

        tableView.delegate = self
        
        errorDelegate.self = self
        
        //create tableviewcell
        setupTableView()
                
      
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
                    self.albums = responseData.results
                    self.tableView.reloadData()
                    if(self.activityView.isAnimating){
                        self.activityView.stopAnimating()
                    }
                }else{
                    self.errorDelegate?.showErrorMessage(message: dataError, title: dataErrorTitle,vc: self,buttonText: closeButtonText)
                }
            })
        }else{
            errorDelegate?.showErrorMessage(message: networkError, title: networkErrorTitle,vc: self,buttonText: closeButtonText)
        }
    }
    
    /**
     showErrorMessage - implemented protocol.
     Showing the alert dialog
     */
    func showErrorMessage(message: String, title: String, vc: ViewController, buttonText: String){
        DispatchQueue.main.async {
            AlertController.showAlert(message: message,title: title,vc: vc,buttonText: buttonText)
            if(self.activityView.isAnimating){
                self.activityView.stopAnimating()
            }
        }
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


protocol AlbumErrorDelegate {
    
    func showErrorMessage(message: String, title: String, vc: ViewController, buttonText: String)
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
            
             let url = album.artworkUrl100
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

