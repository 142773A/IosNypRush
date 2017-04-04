//
//  DotArtCategoryDetailViewController.swift
//  NypSddpProject
//
//  Created by Qi Qi on 27/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class DotArtCategoryDetailViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet weak var viewForMap: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    var mapView : GMSMapView!
    var artCategory : ArtType?
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
  
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var markerList : [GMSMarker] = []
    var tempMarkerList : [GMSMarker] = []
    var selectedUser : User?
    var userProgress : UserDotArt?
    
    var list : [DotArt] = []
    var counter : Int = 0
    var completedCounter : Int = 0
    var actualAnswer : String = ""
    var currentQuestion : Int = 0
    var userDotArtId : Int = 0
    var userScore : Double = 0.00
    var isCompletedCheck :Int = 0
    
    @IBOutlet weak var displayQuestionLabel: UILabel!
    @IBOutlet weak var userAnswerTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userAnswerTextField.delegate = self
        
        // Load the data
        self.loadData();
        
        // When user touch submitButton, we're going to call checkAnswer method
        submitButton.addTarget(self, action: #selector(self.checkAnswer), for: .touchUpInside)
        
    }
    
    /*func textFieldDidBeginEditing(_ textField: UITextField) {
        
        animateViewMoving(up: true, moveValue: 160)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 160)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }*/
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func checkAnswer(){
        //check whether user walk finish first
        
        if(markerList.count != completedCounter){
            //do a error prompt alert
            alertFunc(title: "Incomplete",
                      message: "Please finish joining the dots!",
                      buttonMsg: "OK")
        }
        else if(markerList.count == completedCounter){
            //if connected finish check the answer
            let userAns = userAnswerTextField.text!
            print("\(userAns) and \(actualAnswer)")
            
            if(userAns.caseInsensitiveCompare(actualAnswer) == ComparisonResult.orderedSame){
              //correct!
                
                var checkQ = false
                userScore = userScore + 10.00
                currentQuestion = currentQuestion + 1
                
                if(currentQuestion > 10){
                    userScore = userScore + 20.00
                    isCompletedCheck = isCompletedCheck + 1
                    currentQuestion = 1
                    checkQ = true
                }
                
                
                let qList = DotArtDataManager.loadDotArtChallenge(
                    level: "1",
                    question: "\(currentQuestion)",
                    artTypeId: "\((artCategory?.artTypeId)!)")
                
                //update user answer table to next question

                let result = DotArtUserDataManager.insertNewRecord(
                    userDotArt: UserDotArt(
                        userDotArtId: self.userDotArtId,
                        lat: 0.00,
                        long: 0.00,
                        completion: 0,
                        userId: (selectedUser?.userId)!,
                        dotArtId: qList[0].dotArtId,
                        dotArtCategory: (artCategory?.artTypeId)!,
                        totalScore: userScore,
                        isCompleted: isCompletedCheck))
                
                if(result == true){
                    print("Update sucess")
                    // Load the data
                    markerList = []
                    tempMarkerList = []
                    userAnswerTextField.text = ""
                    mapView.clear()
                    
                    if(checkQ == false){
                        alertFunc(title: "Correct",
                                  message: "Your answer is correct!",
                                  buttonMsg: "Next")
                        
                        self.viewDidLoad()
                        self.viewWillAppear(true)
                    }
                    else{
                        //after done need to delete all the records of the user
                        let deleteResult = DotArtUserDataManager.deleteUserCoordinateAfterDone(userId: (selectedUser?.userId)!,
                                                                                               userDotId: self.userDotArtId,
                                                                                               dotArtCategory: (artCategory?.artTypeId)!)
                        
                        if(deleteResult == true){
                            //show that user successfully
                            
                            let refreshAlert = UIAlertController(
                                title: "Complete",
                                message: "You have sucessfully completed the whole Category!",
                                preferredStyle: UIAlertControllerStyle.alert)
                            
                            refreshAlert.addAction(UIAlertAction(
                                title: "Close",
                                style: .default,
                                handler: { (action: UIAlertAction!) in
                                    
                                    self.navigationController?.popViewController(animated: true)
                                    
                            }))
                            
                            
                            present(refreshAlert, animated: true, completion: nil)
                        }
                        
                        
                    }
                }
                
            }else{
                //incorrect answer
                alertFunc(title: "Wrong",
                          message: "You entered an incorrect answer",
                          buttonMsg: "Try Again")
            }
            
        }
        
    }
    
    func alertFunc(title : String, message : String, buttonMsg : String){
        //one button
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: buttonMsg,
                                      style: UIAlertActionStyle.default,
                                      handler: nil))
        
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    func loadData() {
        // code to load data from network, and refresh the interface
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.distanceFilter = 50
        
        locationManager?.startUpdatingLocation()
        
        
        placesClient = GMSPlacesClient.shared()
        
        let camera = GMSCameraPosition.camera(withLatitude: 1.38012,
                                              longitude: 103.85023,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       
        
        //get the user that was used
        selectedUser = UserDataManager.loadUserByUsername(username: UserDefaults.standard.string(forKey: "username")!)
        
        if(selectedUser != nil){
            let id = "\((selectedUser?.userId)!)"
            let category = "\((artCategory?.artTypeId)!)"
            userProgress =
                DotArtUserDataManager.loadDotArtUserByUserId(userId: id, dotArtCat: category) as! UserDotArt?
            
            if(userProgress != nil){
                //retrieve the dot art that the user last left
                userDotArtId = (userProgress?.userDotArtId)!
                userScore = (userProgress?.totalScore)!
                isCompletedCheck = (userProgress?.isCompleted)!
                
                let tempId = "\((userProgress?.dotArtId)!)"
                let challenge = DotArtDataManager.loadDotArtChallengeById(dotId: tempId)
                
                let l = "\(challenge[0].level)"
                let q = "\(challenge[0].question)"
                let c = "\(challenge[0].artTypeId)"
                
                
                generateMarkers(level: l, question: q, catId: c)
                let progressCount = (userProgress?.completion)!
                
                
                if(progressCount == 0){
                    progressLabel.text = "0 / \( markerList.count)"
                    completedCounter = 0
                }
                else{
                    completedCounter = progressCount
                    progressLabel.text = "\(completedCounter) / \( markerList.count)"
                }
                
                //check whether user pass by markers before or whether they completed certain points.
                let coordList = DotArtUserDataManager.loadUserDotArtCoordinateByUserId(
                    userId: id,
                    userDotArt: "\((userProgress?.userDotArtId)!)")
                
                for c in coordList {
                    for m in markerList {
                        if (c.name == m.title && c.long == m.position.longitude && c.lat == m.position.latitude){
                            
                            m.icon = GMSMarker.markerImage(with: UIColor.green)
                            
                            if (c.linkConnect != "none"){
                                //eg. 1 to 2 check the number
                                let tempCheckLinkList = get_numbers(no: c.linkConnect)
                                
                                let second = "Point \(tempCheckLinkList[1])"
                                var secondMarker : GMSMarker?
                                
                                //draw the line.
                                for tm in 0 ..< markerList.count{
                                    if(markerList[tm].title == second){
                                        secondMarker = markerList[tm]
                                    }
                                }
                                let path = GMSMutablePath()
                                path.add(CLLocationCoordinate2D(
                                    latitude: m.position.latitude,
                                    longitude: m.position.longitude))
                                
                                path.add(CLLocationCoordinate2D(
                                    latitude: (secondMarker?.position.latitude)!,
                                    longitude: (secondMarker?.position.longitude)!))
                                
                                let polyline = GMSPolyline(path: path)
                                polyline.strokeColor = .blue
                                polyline.strokeWidth = 3.0
                                polyline.map = mapView
                            }
                        }
                    }
                }
            }
            else{
                //retrieve the total number of user records
                let total = DotArtUserDataManager.loadDotArtUser().count
                
                // get the dot art first question based on the category the user chose
                let listGroup = DotArtDataManager.loadDotArtChallenge(
                    level: "1", question: "1", artTypeId: category)
                
                // just need the first id from the listGroup
                
                let dotArtID = listGroup[0].dotArtId
                let h = total + 1
                
                let result = DotArtUserDataManager.insertNewRecord(
                    userDotArt: UserDotArt(
                        userDotArtId: h,
                        lat: 0.00,
                        long: 0.00,
                        completion: 0,
                        userId: (selectedUser?.userId)!,
                        dotArtId: dotArtID,
                        dotArtCategory: (artCategory?.artTypeId)!,
                        totalScore: 0.00,
                        isCompleted : 0))
                
                if(result == true){
                    print("Success YAY")
                    userDotArtId = h
                    
                    let id = "\((selectedUser?.userId)!)"
                    let category = "\((artCategory?.artTypeId)!)"
                    
                    userProgress =
                        DotArtUserDataManager.loadDotArtUserByUserId(userId: id, dotArtCat: category) as! UserDotArt?
                    
                    generateMarkers(level: "1", question: "1", catId: category)
                    progressLabel.text = "0 / \( markerList.count)"
                }
            }
        }
        
        viewForMap.addSubview(mapView)

    }
    
    //update User progress function
    func updateUserProgress(latt : Double, lng : Double, complete : Int, qnsId : Int){
        // based on user progress and get the userdotart id and update the values
        let userDotArtId = userProgress?.userDotArtId
        let id = userProgress?.userId
        let catId = artCategory?.artTypeId
        
        let tempUserDotItem = UserDotArt(userDotArtId: userDotArtId!,
                                         lat: latt,
                                         long: lng,
                                         completion: complete,
                                         userId: id!,
                                         dotArtId: qnsId,
                                         dotArtCategory: catId!,
                                         totalScore : userScore,
                                         isCompleted : isCompletedCheck)
        
        let result = DotArtUserDataManager.updateUserCurrentProgress(userDotArt: tempUserDotItem)
        
        if(result == true){
            print ("Update Dot Art qns successfully")
        }
        
    }
    
    
    func generateMarkers(level : String, question: String, catId: String) {
        //mapView.clear()
        
        // retrieve the dot art
      
        self.list = DotArtDataManager.loadDotArtChallenge(level: level,
                                                          question: question,
                                                          artTypeId: catId)
        actualAnswer = list[0].name
        currentQuestion = list[0].question
        
        displayQuestionLabel.text = "QUESTION \(question)"
        //generate the coordinates
        for i in 0 ..< list.count{
           
            let marker = GMSMarker(
                position: CLLocationCoordinate2D(latitude: list[i].lat,
                                                 longitude: list[i].long))
            marker.title = "Point \(i+1)"
            
           // marker.snippet = place.formattedAddress
            marker.map = self.mapView
            
            markerList.append(marker)
        }
        
   
        if(currentQuestion < 3){
            let locationOfPoint1 = GMSCameraPosition.camera(withLatitude: markerList[0].position.latitude,
                                                            longitude: markerList[0].position.longitude,
                                                            zoom: 16)
            mapView.camera = locationOfPoint1
        }else{
            let locationOfPoint1 = GMSCameraPosition.camera(withLatitude: markerList[0].position.latitude,
                                                            longitude: markerList[0].position.longitude,
                                                            zoom: 13)
            mapView.camera = locationOfPoint1
        }
        
    }
    
    var lastLocationUpdateTime : Date = Date ()
   
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        let howRecent = self.lastLocationUpdateTime.timeIntervalSinceNow
        
        if(abs(howRecent) > 0){
             print("Location: \(location)")
            self.lastLocationUpdateTime = Date()
            print ("Markers: \(markerList.count)")
            
            if(markerList.count >= 2 && completedCounter < markerList.count){
                if (list.count >= 2){
                    for a in 0 ..< list.count{
                        //check whether it match 
                        
                        let coordinate2 = CLLocation(latitude: list[a].lat, longitude: list[a].long)
                        
                        //result is in metres
                        let distanceInMeters = location.distance(from: coordinate2)
                        print ("Distance from actual coords: \(distanceInMeters)")
                        
                        if((location.coordinate.longitude ==  list[a].long
                            && location.coordinate.latitude == list[a].lat) || distanceInMeters <= 55){
                            for b in 0 ..< markerList.count{
                                
                                let coordinate3 = CLLocation(
                                    latitude: markerList[b].position.latitude,
                                    longitude: markerList[b].position.longitude)
                                
                                let distanceInMetersMarker = coordinate2.distance(from: coordinate3)
                                
                                print ("Distance from Marker coords: \(distanceInMetersMarker)")
            
                                
                                if ((markerList[b].position.longitude == list[a].long
                                    && markerList[b].position.latitude == list[a].lat) || distanceInMetersMarker  <= 55){
                                
                                    
                                    markerList[b].icon = GMSMarker.markerImage(with: UIColor.green)
                                    
                                    //retrieve the dot art that the user last left
                                    let tempId = "\((userProgress?.dotArtId)!)"
                                    let challenge = DotArtDataManager.loadDotArtChallengeById(dotId: tempId)
                                    
                                    //check if the record already exist else insert
                                    
                                    let coordList = DotArtUserDataManager.loadUserDotArtCoordinate()
                                    var checkExist = false;
                                    
                                    for row in coordList{
                                        if(row.name == markerList[b].title &&
                                            row.long == markerList[b].position.longitude &&
                                            row.lat == markerList[b].position.latitude &&
                                            row.question == challenge[0].question &&
                                            row.dotArtCat == ((artCategory?.artTypeId)!)){
                                             checkExist = true
                                            break
                                        }
                                    }
                                    
                                    if (checkExist == false){
                                        let tempCoordinateItem = UserDotArtCoordinate(
                                            id: (coordList.count + 1),
                                            name: markerList[b].title!,
                                            lat: markerList[b].position.latitude,
                                            long: markerList[b].position.longitude,
                                            linkConnect: "none",
                                            userId: ((selectedUser?.userId)!),
                                            userDotArtId: ((userProgress?.userDotArtId)!),
                                            dotArtCat: ((artCategory?.artTypeId)!),
                                            question: challenge[0].question)
                                        
                                        DotArtUserDataManager.insertNewCoordinate(userDotArtCoordinate: tempCoordinateItem)
                                    }
                                    
                                    self.counter = counter + 1
                                    tempMarkerList.append(markerList[b])
                                }
                                
                            }
                        }
                    }
                    
                    print ("Markers Temp: \(tempMarkerList.count)")
                    
                    if(tempMarkerList.count == 2){
                        print ("Markers Temp 1: \(tempMarkerList[0].title) Markers Temp 2: \(tempMarkerList[1].title)")
                        //check whether the points is in order
                        let first = tempMarkerList[0].title
                        let newFirst = first!.replacingOccurrences(of: "Point ", with: "", options: .literal, range: nil)
                        
                        let second = tempMarkerList[1].title
                        let newSecond = second!.replacingOccurrences(of: "Point ", with: "", options: .literal, range: nil)
                        
                        print ("\(newFirst) jhdjdhjdhjdh \(newSecond)")
                       
                        let checkNo1 = Int(newFirst)! + 1
                        let checkNo2 = Int(newSecond)! - 1
                        
                        let coordList = DotArtUserDataManager.loadUserDotArtCoordinate()
                        let tempId = "\((userProgress?.dotArtId)!)"
                        let challenge = DotArtDataManager.loadDotArtChallengeById(dotId: tempId)
                        
                        if((checkNo1 == Int(newSecond)) ||
                            (checkNo2 == Int(newFirst)) ||
                            (Int(newFirst) == markerList.count && Int(newSecond) == 1)){
                            
                            
                            //check if path already exist
                            for q in coordList{
                                if(q.name == tempMarkerList[0].title &&
                                    q.long == tempMarkerList[0].position.longitude &&
                                    q.lat == tempMarkerList[0].position.latitude &&
                                    q.question == challenge[0].question &&
                                    q.dotArtCat == ((artCategory?.artTypeId)!)){
                                    
                                    if (q.linkConnect == "none"){
                                        // draw path and update
                                        
                                        let path = GMSMutablePath()
                                        path.add(CLLocationCoordinate2D(
                                            latitude: tempMarkerList[0].position.latitude,
                                            longitude: tempMarkerList[0].position.longitude))
                                        
                                        path.add(CLLocationCoordinate2D(
                                            latitude: tempMarkerList[1].position.latitude,
                                            longitude: tempMarkerList[1].position.longitude))
                                        
                                        let polyline = GMSPolyline(path: path)
                                        polyline.strokeColor = .blue
                                        polyline.strokeWidth = 3.0
                                        polyline.map = mapView
                                        
                                      
                                        
                                        completedCounter = completedCounter + 1
                                        progressLabel.text = "\(completedCounter) / \(markerList.count)"
                                        
                                        //update the progress
                                        updateUserProgress(latt: tempMarkerList[1].position.latitude,
                                                           lng: tempMarkerList[1].position.longitude,
                                                           complete: completedCounter,
                                                           qnsId: (userProgress?.dotArtId)!)
                                        
                                        
                                        //update the coords
                                        //retrieve the dot art that the user last left
                                        
                                        //check if the record already exist else update the link
                                        
                                        for row in coordList{
                                            if(row.name == tempMarkerList[0].title &&
                                                row.long == tempMarkerList[0].position.longitude &&
                                                row.lat == tempMarkerList[0].position.latitude &&
                                                row.question == challenge[0].question &&
                                                row.dotArtCat == ((artCategory?.artTypeId)!)){
                                                
                                                //update the item.
                                                DotArtUserDataManager.updateUserCoordinateLink(
                                                    link: "\(newFirst),\(newSecond)",
                                                    id: row.id)
                                                
                                            }
                                        }

                                    }
                                }
                            }
                            
                            
                        }
                        tempMarkerList.remove(at: 0)
                    }
                    
                }
               print("Counter : \(counter)")
            }
            
      }
        
       
        
        /*let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        } */
        
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager?.stopUpdatingLocation()
        print("Error: \(error)")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    // this function will triggered when the view is about to appear
    override func viewWillAppear(_ animated: Bool) {
        //get the category name
        // for dot Art
        self.navigationItem.title = artCategory?.artTypeName
        
        //check whether user has record
  
    }
    // func that convert comma separated number into array
    func get_numbers(no :String) -> Array<Int> {
        return no.components(separatedBy: ",")
            .flatMap {
                Int($0.trimmingCharacters(in: .whitespaces))
        }
    }


}
