//
//  FilterViewController.swift
//  NypSddpProject
//
//  Created by iOS on 24/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit
import MobileCoreServices

class FilterViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var imageToFilter: UIImageView!
    
    @IBOutlet weak var filtersScrollView: UIScrollView!
    
    var CIFilterNames: [String]!
    var labelNames : [String]!
    
    var newImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        originalImage.image = newImage
        self.CIFilterNames = ["None",
                              "CIPhotoEffectChrome",
                              "CIPhotoEffectFade",
                              "CIPhotoEffectInstant",
                              "CIPhotoEffectMono",
                              "CIPhotoEffectNoir",
                              "CIPhotoEffectProcess",
                              "CIPhotoEffectTonal",
                              "CIPhotoEffectTransfer",
                              "CISepiaTone",
                              "CIColorPosterize",
                              "CIFalseColor"]
        
        
        self.labelNames = ["None",
                           "Chrome",
                           "Fade",
                           "Instant",
                           "Mono",
                           "Noir",
                           "Process",
                           "Tonal",
                           "Transfer",
                           "Sepia",
                           "Posterize",
                           "Vintage"]
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 100
        let buttonHeight: CGFloat = 100
        let gapBetweenButtons: CGFloat = 5
        
        var itemCount = 0
        var endingPoint:CGFloat = 0
        for i in 0..<CIFilterNames.count {
            itemCount = i
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            
            filterButton.frame = CGRect(x: xCoord,
                                        y: yCoord,
                                        width: buttonWidth,
                                        height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.addTarget(self,
                                   action: #selector(filterButtonTapped(sender:)),
                                   for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            
            //Add view to wrap labels and the buttons together
            
            // add a label
            let label = UILabel(frame: CGRect(x: xCoord,
                                              y: filterButton.frame.maxY + 5,
                                              width: buttonWidth,
                                              height: 20))
            label.textAlignment = .center
            label.font = label.font.withSize(15)
            label.text = labelNames[i]
            
            // FILTERS
            
            //add original one
            if(i == 0){
                // Create filters for  button
                let coreImage = originalImage.image!
                
                // Assign filtered image to the button
                filterButton.setBackgroundImage(coreImage, for: .normal)
                
                // Add Buttons in the Scroll View
                xCoord +=  buttonWidth + gapBetweenButtons
                filtersScrollView.addSubview(filterButton)
                filtersScrollView.addSubview(label)
                
                
            }
            else{
                // Create filters for each button
                let ciContext = CIContext(options: nil)
                let coreImage = CIImage(image: originalImage.image!)
                let filter = CIFilter(name: "\(CIFilterNames[i])" )
                
                filter!.setDefaults()
                filter!.setValue(coreImage, forKey: kCIInputImageKey)
                let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
                let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
                let imageForButton = UIImage(cgImage: filteredImageRef!);
                
                // Assign filtered image to the button
                filterButton.setBackgroundImage(imageForButton, for: .normal)
                
                if(i == CIFilterNames.count-1){
                    endingPoint = filterButton.frame.maxX
                }
                // Add Buttons in the Scroll View
                xCoord +=  buttonWidth + gapBetweenButtons
                filtersScrollView.addSubview(filterButton)
                filtersScrollView.addSubview(label)
                
                // filtersScrollView.addSubview(filterButton)
            }
            
            
            
        } // END FOR LOOP
        
        
        // Resize Scroll View
        filtersScrollView.contentSize = CGSize(width: endingPoint + gapBetweenButtons,
                                               height: yCoord)
        
    }
    
    
    func filterButtonTapped(sender: UIButton) {
        let button = sender as UIButton
        
        imageToFilter.image = button.backgroundImage(for: UIControlState.normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
