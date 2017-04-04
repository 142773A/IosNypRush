//
//  ChallengerArtViewController.swift
//  NypSddpProject
//
//  Created by Qi Qi on 24/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit

class ChallengerArtViewController: UIViewController {

    @IBOutlet weak var connectDotButton: UIButton!
    
    @IBOutlet weak var pixelArtButton: UIButton!
    
    @IBOutlet weak var photoArtButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         //self.performSegue(withIdentifier: "unwindToThisNotificationController", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectDotAction(_ sender: Any) {
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
