//
//  DataSource.swift
//  EPIC
//
//  Created by VIRAKRI JINANGKUL on 2/21/16.
//  Copyright © 2016 VIRAKRI JINANGKUL. All rights reserved.
//

import UIKit
import CoreLocation

class imageDataSource: NSObject {
    
    
    struct imageDataStruct {
        let imageID: Int
        let imageName: String
        let author: String
        let username: String
        let timeStamp: Double
        let coordinate: CLLocationCoordinate2D
        let stolenNumber: Int
    }
    
    var DataSetted = [
        imageDataStruct(imageID: 1, imageName: "image001.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Dec", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris we", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Jose Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image005.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image003.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image004.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 1, imageName: "image002.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6),
        imageDataStruct(imageID: 2, imageName: "image001.jpg", author: "Chris Mayers", username: "chris", timeStamp: 1.239, coordinate: CLLocationCoordinate2D(latitude: 10.30, longitude: 44.34), stolenNumber: 6)
    ]
    
    
    
}

class userDataSource: NSObject {
    
    
    struct userDataStruct {
        let userID: Int
        let userImage: String
        let username: String
        let userDisplayName: String
    }
    
    var DataSetted = [
        userDataStruct(userID: 1, userImage: "user001.jpg", username: "Chris", userDisplayName: "Mayers"),
        userDataStruct(userID: 1, userImage: "user001.jpg", username: "Chris", userDisplayName: "Mayers"),
        userDataStruct(userID: 1, userImage: "user001.jpg", username: "Chris", userDisplayName: "Mayers"),
        userDataStruct(userID: 1, userImage: "user001.jpg", username: "Chris", userDisplayName: "Mayers"),
        userDataStruct(userID: 2, userImage: "user002.jpg", username: "Chris", userDisplayName: "Name of Me")
    ]
    
    
    
}