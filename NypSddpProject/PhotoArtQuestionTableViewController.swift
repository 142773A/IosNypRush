//
//  PhotoArtQuestionTableViewController.swift
//  NypSddpProject
//
//  Created by iOS on 24/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit
import MobileCoreServices

class PhotoArtQuestionTableViewController: UITableViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate, AnalyzeImageDelegate {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var photoArtTableView: UITableView!
    @IBOutlet weak var uploadedImageView: UIImageView!
    
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultStatus: UILabel!
    @IBOutlet weak var resultDescription: UILabel!
    @IBOutlet weak var resultTag: UILabel!
    // Selected image
    var selctedImage: UIImage!
    let loader = ActivityIndicatorView(text: "Loading ...")
    let validatorLoader = ActivityIndicatorView(text: "Validating ...")
    
    var photoArtObject : PhotoArt?
    var selectedUser : User!
    var defaultImageName : String = "default"
    var haveImageValidated : String = "noValidate"
    
    var retrieveTempImage : UIImage!
    
    @IBOutlet weak var imageQuestionView: UIView!
    
    @IBOutlet weak var scrollviewer: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //get the user that was used
        selectedUser = UserDataManager.loadUserByUsername(username: UserDefaults.standard.string(forKey: "username")!)
        uploadedImageView.clipsToBounds = true
        self.photoArtTableView.addSubview(validatorLoader)
        validatorLoader.hide()
        
        if(retrieveTempImage != nil){
            uploadedImageView.image = retrieveTempImage
            retrieveTempImage = nil
            defaultImageName = "Past"
        }
        
        resultView.isHidden = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        questionLabel.text = photoArtObject!.question
        
        let imageView = uploadedImageView
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(img:)))
        imageView?.isUserInteractionEnabled = true
        imageView?.addGestureRecognizer(tapGestureRecognizer)
        
        photoArtTableView.isScrollEnabled = false
        photoArtTableView.tableFooterView = UIView()
    }
    
    //click to validate button here
    @IBAction func validatePhotoButton(_ sender: Any) {
        
        if(defaultImageName != "default"){
            self.validatorLoader.show()
            
            self.resultDescription.text = ""
            self.resultTag.text = ""
            self.resultStatus.text = ""
            
            //validate whether the image is valid
            //check whether qns is it image, word or both
            let questionType = photoArtObject!.questionType
            
            // not case sensitive
            if (questionType.lowercased().range(of:"image") != nil) {
                if(questionType.lowercased().range(of:"word") != nil){
                    print("image and word")
                    
                    // do image and word processing
                    
                    self.analyseValidateImage(imageViewToValidate: self.uploadedImageView, filterBoth : true)
                    
                    let deadlineTime = DispatchTime.now() + .seconds(5)
                    DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                        self.analyseValidateWord(imageViewToValidate: self.uploadedImageView, filterBoth : true, count : 2)
                        
                    })
                    
                    
                }else{
                    print("image only")
                    
                    //do image processing only
                    analyseValidateImage(imageViewToValidate: uploadedImageView, filterBoth : false)
                }
                
                if(self.resultDescription.text != ""){
                    resultView.isHidden = false
                    photoArtTableView.isScrollEnabled = true
                }
                
            }
            else if (questionType.lowercased().range(of:"word") != nil){
                print("word only")
                
                //do word processing only
                self.resultDescription.text =
                    self.resultDescription.text! 
                analyseValidateWord(imageViewToValidate: uploadedImageView, filterBoth : false, count : 1)
                
                
            }
            
        }
        else{
            alertFunc(title: "No Image", message: "There is no image detected. Please upload a photo", buttonMsg: "Close")
        }
        
        
        
    }
    
    func imageTapped(img: AnyObject)
    {
        // Your action
        // show action shee to choose image source.
        self.showImageSourceActionSheet()
    }
    
    // MARK: image picker delegate function
    
    // set selected image in preview
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // dismiss image picker controller
        picker.dismiss(animated: true, completion: nil)
        
        // if let newImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        // if image selected the set in preview.
        if let newImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            let analyzeImage = CognitiveServices.sharedInstance.analyzeImage
            analyzeImage.reClearView()
            //reduce file quality
            let temp = newImage.jpeg(.low)
            
            print (temp!.count)
            // set selected image into variable
            self.selctedImage = UIImage(data: temp!)
            
            // set preview for selected image
            self.uploadedImageView.image = self.selctedImage
            defaultImageName = "changed"
            
            
        }
    }
    
    // Close image picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // dismiss image picker controller
        picker.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func onClickFilterButton(_ sender: AnyObject) {
        
        if(defaultImageName != "default"){
            
            // The text can be change to suit the needs of the view on the loader
            
            self.photoArtTableView.addSubview(loader)
            loader.show()
            
            self.haveImageValidated = "yesValidate"
            let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                // Your code with delay
                
                // Your action
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
                
                
                controller.newImage = self.uploadedImageView.image
                
                self.present(controller, animated: true, completion: nil)
                
                
            }
            
            if(haveImageValidated == "yesValidate"){
                let analyzeImage = CognitiveServices.sharedInstance.analyzeImage
                analyzeImage.delegate = self
                analyzeImage.reClearView()
            }
        }
        else{
            alertFunc(title: "No Image", message: "There is no image detected. Please upload a photo", buttonMsg: "Close")
        }
       
        
        
        
    }
    
    
    // MARK: - Utility functions {
    
    // Show action sheet for image source selection
    fileprivate func showImageSourceActionSheet() {
        
        // create alert controller having style as ActionSheet
        let alertCtrl = UIAlertController(title: "Select Image Source" , message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // create photo gallery action
        let galleryAction = UIAlertAction(title: "Photo Gallery", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
            self.showPhotoGallery()
            }
        )
        
        // create camera action
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
            self.showCamera()
            }
        )
        
        // create cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        // add action to alert controller
        alertCtrl.addAction(galleryAction)
        alertCtrl.addAction(cameraAction)
        alertCtrl.addAction(cancelAction)
        
        // do this setting for ipad
        alertCtrl.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = alertCtrl.popoverPresentationController
      
        
        
        // present action sheet
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
    // Show alert message with OK button
    func showAlertMessage(alertTitle: String, alertMessage: String) {
        
        let myAlertVC = UIAlertController( title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlertVC.addAction(okAction)
        
        self.present(myAlertVC, animated: true, completion: nil)
    }
    
    
    // Show photo gallery to choose image
    fileprivate func showPhotoGallery() -> Void {
        
        // debug
        print("Choose - Photo Gallery")
        
        // show picker to select image form gallery
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            
            // create image picker
            let imagePicker = UIImagePickerController()
            
            // set image picker property
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            
            // show image picker
            self.present(imagePicker, animated: true, completion: nil)
            
        }else{
            self.showAlertMessage(alertTitle: "Not Supported", alertMessage: "Device can not access gallery.")
        }
        
    }
    
    
    // Show camera to capture image
    fileprivate func showCamera() -> Void {
        
        // debug
        print("Choose - Camera")
        
        // show camera
        if( UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            
            // create image picker
            let imagePicker = UIImagePickerController()
            
            // set image picker property
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
            imagePicker.allowsEditing = true
            
            // show image picker with camera.
            self.present(imagePicker, animated: true, completion: nil)
            
        }else {
            self.showAlertMessage(alertTitle: "Not Supported", alertMessage: "Camera not supported in emulator.")
        }
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
   /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == "FilterImage" {
            print("hfhdsgh")
         
            
        }
        
     } */

    
    @IBAction func unwindToThisPhotoArtQuestionController(segue: UIStoryboardSegue) {
        print("Returned from detail screen")
        
        if let sourceViewController = segue.source as? FilterViewController {
            loader.hide()
            if(sourceViewController.imageToFilter.image == nil){
                self.uploadedImageView.image = sourceViewController.originalImage.image
            }else{
                self.uploadedImageView.image = sourceViewController.imageToFilter.image
            }
            
        }
        
    }
    
    
   
    // MARK: - TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    // MARK: - AnalyzeImageDelegate
    
    func finnishedGeneratingObject(_ analyzeImageObject: AnalyzeImage.AnalyzeImageObject) {
        
        // Here you could do more with this object. It for instance contains the recognized emotions that weren't available before.
        print(analyzeImageObject)
    }
    
    func analyseValidateImage (imageViewToValidate : UIImageView, filterBoth : Bool){
        let analyzeImage = CognitiveServices.sharedInstance.analyzeImage
        analyzeImage.delegate = self
        
        let visualFeatures: [AnalyzeImage.AnalyzeImageVisualFeatures] =
            [.Categories,
             .Description,
             .Faces,
             .ImageType,
             .Color,
             .Adult]
        
        let requestObject: AnalyzeImageRequestObject =
            (imageViewToValidate.image!, visualFeatures)
        
        try! analyzeImage.analyzeImageWithRequestObject(requestObject, image: imageViewToValidate.image!, imageView: imageViewToValidate, completion: { (response) in
            DispatchQueue.main.async(execute: {
                self.resultDescription.text = self.resultDescription.text! + (response?.descriptionText)!
                
                var tags = ""
                let n = 15
                var wholeArray = (response?.tags)!
                
                var limitedTags : [String] = []
                
                if (wholeArray.count > n){
                    for i in 0 ..< n{
                        limitedTags.append(wholeArray[i])
                    }
                }
                else{
                    limitedTags = wholeArray
                }
               
                for item in limitedTags{
                    if(tags == ""){
                        tags = tags + item
                    }else{
                        tags = tags + " , " + item
                    }
                    
                }
                self.resultTag.text = self.resultTag.text! + tags
                
                if(filterBoth == false) {
                    if(self.resultDescription.text != ""){
                        
                        
                       
                        
                        let when = DispatchTime.now() + 8 // change to desired number of seconds
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            self.validateStatus(errorMessage:  "")
                            self.resultView.isHidden = false
                            self.photoArtTableView.isScrollEnabled = true
                            analyzeImage.clearList()
                            self.validatorLoader.hide()
                           
                        }
                       
                        
                     
                       
                    }
                    
                }
                
            })
        })
        
        
    }
    
    func analyseValidateWord (imageViewToValidate : UIImageView, filterBoth : Bool, count : Int){
        let requestObject: OCRRequestObject =
            (resource: UIImagePNGRepresentation(imageViewToValidate.image!)!,
             language: .Automatic,
             detectOrientation: true)
        
        let ocr = CognitiveServices.sharedInstance.ocr
        try! ocr.recognizeCharactersWithRequestObject(requestObject, completion: { (response) in
            let text = ocr.extractStringFromDictionary(response!)
            var errorMessage = ""
            
            if(text == ""){
                errorMessage = "-"
            }
            else{
                errorMessage = ""
            }
            
            if(count == 2){
                self.resultDescription.text =
                    self.resultDescription.text! + "\nWord Filtered Out: " + errorMessage
                self.resultDescription.text = self.resultDescription.text! + text
            }
            else{
                self.resultDescription.text =
                    self.resultDescription.text! + "Word Filtered Out: " + errorMessage
                self.resultDescription.text = self.resultDescription.text! + text
            }
            
            
            
            if(self.resultDescription.text != "" && count == 1 && filterBoth == false){
                
                self.resultView.isHidden = false
                self.photoArtTableView.isScrollEnabled = true
                self.validatorLoader.hide()
                
            }
            
            if(count == 2 && filterBoth == true && self.resultDescription.text != "" ){
                 self.validateStatus(errorMessage: errorMessage)
                self.resultView.isHidden = false
                self.photoArtTableView.isScrollEnabled = true
              
                self.validatorLoader.hide()
               
            }
            self.validateStatus(errorMessage: errorMessage)
        
        })
        
       
    }
    
    func validateStatus(errorMessage : String){
 
        self.resultStatus.text = ""
            //filter whether the result is successful
            
            /* Guides
             
             Person; Int
             
             Gender; male:0,female:0 / none
             
             Object; values / none
             
             Age; >= <= > < = to / none
             
             Emotion; happiness, disgust, anger, surprise, neutral, sadness, contempt, fear /none
             
             Word; values / none
             
             */
            
            // retrieve the photo art validate
            
            let photoArtValidateObject = PhotoArtDataManager.loadPhotoArtValidateByPhotoArtId(photoArtId: (self.photoArtObject?.photoArtId)!)
            
            if(photoArtValidateObject.count > 0){
                
                //all the values
                let personValue = photoArtValidateObject[0].person
                let gender = photoArtValidateObject[0].gender
                let object = photoArtValidateObject[0].object
                let age = photoArtValidateObject[0].age
                let emotion = photoArtValidateObject[0].emotion
                let word = photoArtValidateObject[0].word
                
                
                //declare bool check
                
                var personCheck = true
                var genderCheck = true
                var objectCheck = true
                var ageCheck = true
                var emotionCheck = true
                var wordCheck = true
                
                if(personValue > 0){
                    personCheck = CognitiveServices.sharedInstance.analyzeImage.validateImageValue(keyToValidate: "Person", validateObject: photoArtValidateObject[0])
                }
                
                if(gender != "none"){
                    genderCheck = CognitiveServices.sharedInstance.analyzeImage.validateImageValue(keyToValidate: "Gender", validateObject: photoArtValidateObject[0])
                }
                
                if(object != "none"){
                    objectCheck = CognitiveServices.sharedInstance.analyzeImage.validateImageValue(keyToValidate: "Object", validateObject: photoArtValidateObject[0])
                }
                
                if(age != "none"){
                    ageCheck = CognitiveServices.sharedInstance.analyzeImage.validateImageValue(keyToValidate: "Age", validateObject: photoArtValidateObject[0])
                }
                
                if(emotion != "none"){
                    emotionCheck = CognitiveServices.sharedInstance.analyzeImage.validateImageValue(keyToValidate: "Emotion", validateObject: photoArtValidateObject[0])
                }
                
                if(word != "none"){
                    wordCheck = CognitiveServices.sharedInstance.ocr.validateWordValue(keyToValidate: "Word", validateObject: photoArtValidateObject[0])
                }
                
                
                if (personCheck == true && genderCheck == true && objectCheck == true && ageCheck == true && emotionCheck == true && wordCheck == true && errorMessage != "-" ){
                    self.resultStatus.text = "Valid"
                    self.resultStatus.textColor = UIColor(red:0.22, green:0.82, blue:0.12, alpha:1.0)
                }else{
                    self.resultStatus.text = "Invalid"
                    self.resultStatus.textColor = UIColor.red
                }
                
                
            }
    }
    
    @IBAction func saveImageButtonAction(_ sender: Any) {
        
        let userDirectoryPath  = "user_\(selectedUser.username)"
        let segmentId = photoArtObject!.segmentId
        let qns = photoArtObject!.photoArtId
        let imageNamePath = "\(selectedUser.username)_segment\(segmentId)_qns\(qns)_image.jpg"
        
        if(self.resultStatus.text == "Valid"){
            //create a directory for the user first to store all their answers there
            createDirectory(directoryPathName: userDirectoryPath)
            // save image
            saveImageDocumentDirectory(image: uploadedImageView.image!, imageName: imageNamePath, directoryPathName: userDirectoryPath)
            
            /*
             id: allUsersPhotoArt.count + 1,
             segmentId: 1,
             colNo: 0,
             rowNo: 0,
             completionRate: 0,
             userId: user.userId,
             photoArtId: 1,
             totalScore: 0.0,
             completed: 0)
             */
            
            //load user current progress
            
            let userPhotoArt = PhotoArtUserDataManager.loadPhotoArtUserByUserId(userId: "\(selectedUser.userId)") as! UserPhotoArt
            
            var checkEntered = false
            //check whether the progress already existed fot that row in a for loop
            let tempUserProgressList = PhotoArtUserDataManager.loadPhotoArtUsersProgressByUserId(userId: "\(selectedUser.userId)")
            
            for item in tempUserProgressList{
                if(item.segmentId == segmentId){
                    if(photoArtObject?.colNo == item.colNo && photoArtObject?.rowNo == item.rowNo){
                        checkEntered = true
                    }
                }
            }
            
            if(checkEntered == false){
                userPhotoArt.totalScore = userPhotoArt.totalScore + 10
                userPhotoArt.completionRate = userPhotoArt.completionRate + 1
            }
            
            //load segment by id
            
            let selectedSeg = PhotoArtDataManager.loadPhotoArtSegmentsById(segmentId: segmentId)
            if(userPhotoArt.completionRate == selectedSeg.totalCubes){
                userPhotoArt.totalScore = userPhotoArt.totalScore + 20
                userPhotoArt.isCompletedCategory = userPhotoArt.isCompletedCategory + 1
            }
        
            userPhotoArt.segmentId = (photoArtObject?.segmentId)!
            userPhotoArt.colNo = (photoArtObject?.colNo)!
            userPhotoArt.rowNo = (photoArtObject?.rowNo)!
            userPhotoArt.photoArtId = (photoArtObject?.photoArtId)!
            
            
            
            //update the user photo art record for their answer
            if(PhotoArtUserDataManager.insertNewRecord(userPhotoArt: userPhotoArt) == true){
                var statusIndicator = 0
                if(resultStatus.text == "Valid"){
                    statusIndicator = 1
                }
                
                var userProgressId = 0
                let count = PhotoArtUserDataManager.loadAllPhotoArtUsersProgress().count
                //check for user id and user phot art id in user progress
                let userProgress = PhotoArtUserDataManager.loadPhotoArtUserProgressByUserIdSegmentColRow(userId: "\(userPhotoArt.userId)",
                                                                                            segmentId: "\(userPhotoArt.segmentId)",
                                                                                            colNo: "\(userPhotoArt.colNo)",
                                                                                            rowNo: "\(userPhotoArt.rowNo)" )
                if(userProgress != nil){
                    userProgressId = (userProgress as! UserPhotoArtProgress).userPhotoArtProgressId
                }else{
                    userProgressId = count + 1
                }
                
                //create or update a user photo art progress
                
                let newUserProgress = UserPhotoArtProgress(id: userProgressId,
                                                           colNo: userPhotoArt.colNo,
                                                           rowNo: userPhotoArt.rowNo,
                                                           imageUrl: userDirectoryPath + "/" + imageNamePath,
                                                           userId: userPhotoArt.userId,
                                                           userPhotoArtId: userPhotoArt.userPhotoArtId,
                                                           segmentId: userPhotoArt.segmentId,
                                                           descriptionGenerated: resultDescription.text!,
                                                           tags: resultTag.text!,
                                                           status: statusIndicator)
           
                if(PhotoArtUserDataManager.insertNewRecordProgress(userPhotoArtPrgoress: newUserProgress) == true){
                   print("done")
                    let completeAlert = UIAlertController(
                        title: "Success",
                        message: "You have sucessfully save your answer!",
                        preferredStyle: UIAlertControllerStyle.alert)
                    
                    completeAlert.addAction(UIAlertAction(
                        title: "Close",
                        style: .default,
                        handler: { (action: UIAlertAction!) in
                            
                            self.performSegue(withIdentifier: "unwindToThisPhotoSegmentViewController", sender: self)
                            
                    }))
                    
                    present(completeAlert, animated: true, completion: nil)
                }
            }
            
        }
        else{
            alertFunc(title: "Invalid Image", message: "The image you chose does not answer the question. Please choose another photo!", buttonMsg: "Try Again")
        }
    }
    
    //create a directory first
    
    func createDirectory(directoryPathName : String){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(directoryPathName)
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Directory already created.")
        }
    }
    
    
    
    // save image document
    func saveImageDocumentDirectory(image : UIImage, imageName : String, directoryPathName: String){
        let fileManager = FileManager.default

        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(directoryPathName)
        let finalPath = paths + "/" + imageName
        print(finalPath)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: finalPath as String, contents: imageData, attributes: nil)
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
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   

}
