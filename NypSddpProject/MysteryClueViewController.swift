 //
 //  MysteryClueViewController.swift
 //  NypSddpProject
 //
 //  Created by iOS on 17/1/17.
 //  Copyright © 2017 NYP. All rights reserved.
 //
 
 import UIKit
 
 class MysteryClueViewController: UIViewController {
    
    @IBOutlet weak var clueDescription: UILabel!
    @IBOutlet weak var clueImage: UIImageView!
    var clueList : [CluedoClue] = []
    var clueAnswerList : [CluedoAnswer] = []
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        
//        clueList = MysteryClueDataManager.loadClue()
//        clueAnswerList = MysteryClueDataManager.loadAnswer()
//        
//        let clueIndex = defaults.string(forKey: "Index")
//        let clueAnswerIndex = defaults.string(forKey: "AnswerIndex")
//        var completedClue = defaults.array(forKey: "completedClue") as? [Int] ?? [Int]()
//        
//        print( "HI   \(completedClue.count) " )
//        
//        if(completedClue.count == 5) {
//            if (clueAnswerIndex != nil)
//            {
//                let index = Int(clueAnswerIndex!)
//                print("Index : \(index!)")
//                clueDescription.text = clueAnswerList[index!].clueAnswerDescription
//                if let imageName = clueAnswerList[index!].clueAnswerImage
//                {
//                    clueImage.image = UIImage(named : (imageName))
//                }
//            }else{
//                let randomIndex = Int(arc4random_uniform(UInt32(clueAnswerList.count)))
//                print(randomIndex)
//                clueDescription.text = clueAnswerList[randomIndex].clueAnswerDescription
//                if let imageName = clueAnswerList[randomIndex].clueAnswerImage
//                {
//                    clueImage.image = UIImage(named : (imageName))
//                }
//                defaults.set(randomIndex, forKey: "AnswerIndex")
//            }
//        }else{
//            
//            if (clueIndex != nil)
//            {
//                let index = Int(clueIndex!)
//                print("Index : \(index)")
//                clueDescription.text = clueList[index!].clueDescription
//                if let imageName = clueList[index!].clueImage
//                {
//                    clueImage.image = UIImage(named : (imageName))
//                }
//            }else{
//                let randomIndex = Int(arc4random_uniform(UInt32(clueList.count)))
//                print(randomIndex)
//                clueDescription.text = clueList[randomIndex].clueDescription
//                if let imageName = clueList[randomIndex].clueImage
//                {
//                    clueImage.image = UIImage(named : (imageName))
//                }
//                defaults.set(randomIndex, forKey: "Index")
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        clueList = MysteryClueDataManager.loadClue()
        clueAnswerList = MysteryClueDataManager.loadAnswer()
        
        let clueIndex = defaults.string(forKey: "Index")
        let clueAnswerIndex = defaults.string(forKey: "AnswerIndex")
        var completedClue = defaults.array(forKey: "completedClue") as? [Int] ?? [Int]()
        
       // print( "HI   \(completedClue.count) " )
        
        if(completedClue.count == 5) {
            if (clueAnswerIndex != nil)
            {
                let index = Int(clueAnswerIndex!)
               // print("Index : \(index!)")
                clueDescription.text = clueAnswerList[index!].clueAnswerDescription
                if let imageName = clueAnswerList[index!].clueAnswerImage
                {
                    clueImage.image = UIImage(named : (imageName))
                }
            }else{
                let randomIndex = Int(arc4random_uniform(UInt32(clueAnswerList.count)))
               // print(randomIndex)
                clueDescription.text = clueAnswerList[randomIndex].clueAnswerDescription
                if let imageName = clueAnswerList[randomIndex].clueAnswerImage
                {
                    clueImage.image = UIImage(named : (imageName))
                }
                defaults.set(randomIndex, forKey: "AnswerIndex")
            }
        }else{
            
            if (clueIndex != nil)
            {
                let index = Int(clueIndex!)
               // print("Index : \(index)")
                clueDescription.text = clueList[index!].clueDescription
                if let imageName = clueList[index!].clueImage
                {
                    clueImage.image = UIImage(named : (imageName))
                }
            }else{
                let randomIndex = Int(arc4random_uniform(UInt32(clueList.count)))
             //   print(randomIndex)
                clueDescription.text = clueList[randomIndex].clueDescription
                if let imageName = clueList[randomIndex].clueImage
                {
                    clueImage.image = UIImage(named : (imageName))
                }
                defaults.set(randomIndex, forKey: "Index")
            }
        }
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
