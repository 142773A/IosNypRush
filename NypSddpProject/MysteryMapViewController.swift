//
//  MysteryMapViewController.swift
//  NypSddpProject
//
//  Created by iOS on 17/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit
import GoogleMaps

class MysteryMapViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet var mapView: GMSMapView!
    
    var clueList : [CluedoClue] = []
    var clueAnswerList : [CluedoAnswer] = []
    let defaults = UserDefaults.standard
    var clueCoordinate = CLLocation()
    var globalClueIndex = Int()
    
    
    var locationManager : CLLocationManager?
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Could not find location: \(error)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clueList = MysteryClueDataManager.loadClue()
        clueAnswerList = MysteryClueDataManager.loadAnswer()
        locationManager = CLLocationManager()
        
        let clueIndex = defaults.integer(forKey: "Index")
        let clueAnswerIndex = defaults.integer(forKey: "AnswerIndex")
        var completedClueTotal = defaults.array(forKey: "completedClue") as? [Int] ?? [Int]()
        
        if (completedClueTotal.count == 5){
            globalClueIndex = clueAnswerIndex
            
            let retrieveClueCoordinate = CLLocation(latitude: clueAnswerList[clueAnswerIndex].clueAnswerLat, longitude: clueAnswerList[clueAnswerIndex].clueAnswerLng)
            
            clueCoordinate = retrieveClueCoordinate
            
        }else {
            
            globalClueIndex = clueIndex
            
            let retrieveClueCoordinate = CLLocation(latitude: clueList[clueIndex].lat, longitude: clueList[clueIndex].lng)
            
            clueCoordinate = retrieveClueCoordinate
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: 1.290270, longitude: 103.851959, zoom: 11.0)
        let googleMap = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        

        // Do any additional setup after loading the view.
        
        /*
         clueList = MysteryClueDataManager.loadClue()
         clueAnswerList = MysteryClueDataManager.loadAnswer()
         
         let clueIndex = defaults.integer(forKey: "Index")
         let clueAnswerIndex = defaults.integer(forKey: "AnswerIndex")
         var completedClueTotal = defaults.array(forKey: "completedClue") as? [Int] ?? [Int]()
         
         if (completedClueTotal.count == 5){
         globalClueIndex = clueAnswerIndex
         
         let retrieveClueCoordinate = CLLocation(latitude: clueAnswerList[clueAnswerIndex].clueAnswerLat, longitude: clueAnswerList[clueAnswerIndex].clueAnswerLng)
         
         clueCoordinate = retrieveClueCoordinate
         
         }else {
         
         globalClueIndex = clueIndex
         
         let retrieveClueCoordinate = CLLocation(latitude: clueList[clueIndex].lat, longitude: clueList[clueIndex].lng)
         
         clueCoordinate = retrieveClueCoordinate
         }
         
         let camera = GMSCameraPosition.camera(withLatitude: 1.290270, longitude: 103.851959, zoom: 11.0)
         let googleMap = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
         
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyBest
         
         locationManager.requestWhenInUseAuthorization()
         locationManager.requestAlwaysAuthorization()
         locationManager.startUpdatingLocation()
         
         self.view = googleMap */
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedWhenInUse){
            mapView.isMyLocationEnabled = true
        }
    }
    
    var lastLocationUpdateTime : Date = Date()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        
        mapView.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 15)
        //mapView.settings.myLocationButton = true
        
        self.view = mapView
        
        let howRecent = self.lastLocationUpdateTime.timeIntervalSinceNow
        
        if (abs(howRecent) > 5)
        {
            checkUserPosition(userLat: newLocation!.coordinate.latitude, userLng: newLocation!.coordinate.longitude)
        }
    }
    
    var alertCheck : Bool = true
    
    func checkUserPosition(userLat: Double , userLng: Double){
        let userLocation = CLLocation(latitude: userLat, longitude: userLng)
        
        let distanceInMeters = clueCoordinate.distance(from: userLocation)
        
        if (distanceInMeters <= 50){
            
            // locationManager.stopUpdatingLocation()
            if (alertCheck) {
                
                var completedClue = defaults.array(forKey: "completedClue") as? [Int] ?? [Int]()
                
                if (completedClue.count == 5) {
                    defaults.removeObject(forKey: "completedClue")
                    
                    let randomIndex = Int(arc4random_uniform(UInt32(clueList.count)))
                    
                    defaults.set(randomIndex, forKey: "Index")
                    
                    let alertController = UIAlertController(title: "Clue Solved !", message: "Congratulation ! You have completed this Cluedo Game !", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                        (action: UIAlertAction!) in
                        
                        self.navigationController!.popViewController(animated: true)
                    }))
                    
                    present(alertController, animated: true, completion: nil)
                    
                    alertCheck = false
                    
                }else{
                    
                    completedClue.append(globalClueIndex)
                    
                    defaults.set(completedClue, forKey: "completedClue")
                    
                    var randomIndex = Int(arc4random_uniform(UInt32(clueList.count)))
                    
                    for item in completedClue {
                        
                        /* if (item == randomIndex){
                         randomIndex = Int(arc4random_uniform(UInt32(clueList.count)))
                         }*/
                        
                        while (item == randomIndex){
                            randomIndex = Int(arc4random_uniform(UInt32(clueList.count)))
                        }
                        
                        defaults.set(randomIndex, forKey: "Index")
                    }
                    
                    // defaults.set(randomIndex, forKey: "Index")
                    
                    let alertController = UIAlertController(title: "Clue Solved !", message: "Congratulation ! You have found the location of this clue !", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                        (action: UIAlertAction!) in
                        
                        self.navigationController!.popViewController(animated: true)
                    }))
                    
                    present(alertController, animated: true, completion: nil)
                    
                    alertCheck = false
                    
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clueList = MysteryClueDataManager.loadClue()
        clueAnswerList = MysteryClueDataManager.loadAnswer()
        locationManager = CLLocationManager()
        
        let clueIndex = defaults.integer(forKey: "Index")
        let clueAnswerIndex = defaults.integer(forKey: "AnswerIndex")
        var completedClueTotal = defaults.array(forKey: "completedClue") as? [Int] ?? [Int]()
        
        if (completedClueTotal.count == 5){
            globalClueIndex = clueAnswerIndex
            
            let retrieveClueCoordinate = CLLocation(latitude: clueAnswerList[clueAnswerIndex].clueAnswerLat, longitude: clueAnswerList[clueAnswerIndex].clueAnswerLng)
            
            clueCoordinate = retrieveClueCoordinate
            
        }else {
            
            globalClueIndex = clueIndex
            
            let retrieveClueCoordinate = CLLocation(latitude: clueList[clueIndex].lat, longitude: clueList[clueIndex].lng)
            
            clueCoordinate = retrieveClueCoordinate
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: 1.290270, longitude: 103.851959, zoom: 11.0)
        let googleMap = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        
        // self.view = googleMap
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
