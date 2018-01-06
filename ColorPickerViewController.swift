//
//  ColorPickerViewController.swift
//  Snapchat Text Effects! Make Your Snap Stand Out
//
//  Created by James Williams on 05/01/2017.
//  Copyright © 2017 James Williams. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {
    let colorPicker = SwiftHSVColorPicker(frame: CGRect(x:10, y:30, width:UIScreen.main.bounds.width-20, height:400))
    //var colorPicked = UIColor.red
    var isStart = false
    var fontName = ""
    var size:Double = 0.0
    var otherColor = UIColor.red
    var colorToSet = UIColor.red
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(colorPicker)
        colorPicker.setViewColor(colorToSet)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print(segue.identifier)
        if segue.identifier == "colorPicked" {
            if let destination = segue.destination as? FirstViewController {
                if isStart {
                    destination.startButtonColor = colorPicker.color
                    destination.endButtonColor = otherColor
                } else {
                    destination.endButtonColor = colorPicker.color
                    destination.startButtonColor = otherColor
                }
                
                // will always be gradient if color picker being used
                destination.a = "Gradient"
                destination.b = fontName
                destination.c = size
            }
        }
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
