//
//  NetworkManager.swift
//  AlbumGerne
//
//  Created by Spoorthy Kancharla on 1/3/20.
//  Copyright © 2020 Spoorthy Kancharla. All rights reserved.
//

import Foundation
import SystemConfiguration

/**
 NetworkManager - Handle all newtork related methods
 */
class NetworkManager{
    
    /**
     isConnectedtoNetwork - check if the device is connected to internet(Wifi/3G)
        return true if connected to internet
        else false
     */
    class func isConnectedtoNetwork() -> Bool
    {
        
        var address = sockaddr_in();
        
        address.sin_len = UInt8(MemoryLayout.size(ofValue: address));
        address.sin_family = sa_family_t(AF_INET);
        
        guard let defaultRoute = withUnsafePointer(to: &address, {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                
                SCNetworkReachabilityCreateWithAddress(nil, $0)
                
            }
            
        }) else {
            
            return false
        }
        
        var flags : SCNetworkReachabilityFlags = [];
        if SCNetworkReachabilityGetFlags(defaultRoute, &flags) {
            
            let isReachable = flags.contains(.reachable);
            let needConnection = flags.contains(.connectionRequired);
            
            return(isReachable && !needConnection);
        }else{
            return false
        }
    }
    
    /**
     fetchAlbums - call the itunes webservice api for getting the albums
     urlString - itunes api
     retrun- album data or error if any
     */
    class func fetchAlbums(urlString: String, completionHandler: @escaping (AlbumResult?, NSString?) -> Void) {
        if let url = URL(string: urlString){
          let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler( nil, "\(fetchError) : \(error)" as NSString)
              return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                    completionHandler( nil, "\(invalidResponseError)" as NSString)
              return
            }
            
            
            // got the album data from server so need to call back the homeviewcontroller
            do {
                if let responseData = data{
                   let response = try JSONDecoder().decode(AlbumFeed.self, from: responseData)
                   DispatchQueue.main.async {
                      completionHandler( response.feed, nil)
                   }
                }
            } catch{
                completionHandler( nil, "\(invalidResponseError)" as NSString)
            }
          })
          task.resume()
        }
    }
    
    
}
