//
//  PopOverViewController.swift
//  NypSddpProject
//
//  Created by iOS on 31/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {

    var post : Post!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getImagePath(filePath: "forum")
        getImage(filePath: "forum/\(post!.postImage!)", imageView: myImageView)
        print(post!.postImage!)
//        let newCommentImg: UIImage! = UIImage(named: "person.png")
//        myImageView.clipsToBounds = true
//        myImageView.image = newCommentImg
//        //view.addSubview(dismissButton)
        // Do any additional setup after loading the view.
    }

    func getImage(filePath : String, imageView : UIImageView){
        let fileManager = FileManager.default
        let imagePAth = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filePath)
        if fileManager.fileExists(atPath: imagePAth){
            imageView.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
            imageView.image = UIImage(named: "question_mark_box")
        }
    }
    
    func getImagePath(filePath : String) -> String{
        let fileManager = FileManager.default
        let imagePAth = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filePath)
        if fileManager.fileExists(atPath: imagePAth){
            return imagePAth
        }else{
            print("No Image")
            return ""
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneHandler(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
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
