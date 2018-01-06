//
//  FirstViewController.swift
//  Snapchat Text Effects! Make Your Snap Stand Out
//
//  Created by James Williams on 01/01/2017.
//  Copyright © 2017 James Williams. All rights reserved.
//

import UIKit
import GoogleMobileAds


class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var effectName: UITextField!
    
    var isStartColorBeingPicked = false
    var isEndColorBeingPicked = false

    var a = "Rainbow"
    var b = "Helvetica"
    var c = 25.0
    
    var effectPicker: UIPickerView!
    
    var fontPicker: UIPickerView!

    @IBOutlet weak var adBanner: GADBannerView!
    var startButtonColor:UIColor = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1)
    var endButtonColor:UIColor = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1)
    
    @IBAction func helpButtonClicked(_ sender: UIButton) {
        if (pickerUIView.isHidden) {
            UIApplication.shared.openURL(URL(string: "http://starfi.github.io/snap")!)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        effectPicker = UIPickerView()
        
        fontPicker = UIPickerView()

        
        // PICKER VIEW INIT
        
        textEntryField.returnKeyType = .done
        textEntryField.delegate = self
        
        
        effectPicker.backgroundColor = UIColor.white
        
        effectPicker.showsSelectionIndicator = true
        effectPicker.delegate = self
        effectPicker.dataSource = self
        
        
        fontPicker.backgroundColor = UIColor.white
        
        fontPicker.showsSelectionIndicator = true
        fontPicker.delegate = self
        fontPicker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = self.view.tintColor
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FirstViewController.pickerDone))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FirstViewController.pickerDone))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        effectTextField.inputView = effectPicker
        effectTextField.inputAccessoryView = toolBar
        
        fontTextField.inputView = fontPicker
        fontTextField.inputAccessoryView = toolBar
        
        // END PICKER VIEW INIT
        
        effectName.text = a
        fontTextField.text = b
        sizeSlider.value = Float(c)
        sizeLabel.text = "Size: (\(c))"
        
        adBanner.adUnitID = "ca-app-pub-2004135778380140/8710825313"
        adBanner.rootViewController = self
        adBanner.load(GADRequest())
        
        webView.scrollView.isScrollEnabled = false
        
        startColorButton.setTitleColor(startButtonColor, for: .normal)
        endColorButton.setTitleColor(endButtonColor, for: .normal)
        
        if (effectTextField.text != "Gradient") {
            startColorButton.isHidden = true
            endColorButton.isHidden = true
        } else {
            startColorButton.isHidden = false
            endColorButton.isHidden = false
        }
        
        updateWebView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func hideTextField(){
        textEntryField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Delegates
    
    // 0 - effect
    // 1 - text

    let effectPickerData = ["Rainbow", "Gradient"]
    let fontPickerData = ["Helvetica", "EuphemiaUCAS", "Cochina", "Copperplate",
                          "Damascus", "Farah", "HelveticaNeue-UltraLight", "Zapfino"]

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        /**if (pickerView == effectPicker) {
            return effectPickerData.count
        } else if (pickerView == fontPicker) {
            return fontPickerData.count
        }**/
        
        return 1
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        /**if (pickerView == effectPicker) {
            return effectPickerData.count
        } else if (pickerView == fontPicker) {
            return fontPickerData.count
        }**/
        
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == effectPicker) {
            return effectPickerData.count
            
        } else if (pickerView == fontPicker){
            return fontPickerData.count
        }
        return 5
    }

    
    //MARK: Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == effectPicker) {
            return effectPickerData[row]
        } else if (pickerView == fontPicker) {
            return fontPickerData[row]
        }
        return "meme"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ColorPickerViewController {
            if (sender as! UIButton) == startColorButton!{
                destination.isStart = true
                destination.colorToSet = startButtonColor
                destination.otherColor = endButtonColor
            } else if (sender as! UIButton) == endColorButton! {
                destination.isStart = false
                destination.colorToSet = endButtonColor
                destination.otherColor = startButtonColor
            }
            
            destination.fontName = fontTextField.text!
            destination.size = round(Double(sizeSlider.value))
        }

    }
    @IBAction func effectTextChanged(_ sender: Any) {
        
        if (effectTextField.text != "Gradient") {
            startColorButton.isHidden = true
            endColorButton.isHidden = true
        } else {
            startColorButton.isHidden = false
            endColorButton.isHidden = false
        }
        
        updateWebView()
        
    }
    @IBAction func fontTextChanged(_ sender: Any) {
        updateWebView()
    }
    
    func pickerDone() {
        effectTextField.resignFirstResponder()
        fontTextField.resignFirstResponder()
        
        if (effectTextField.text != "Gradient") {
            startColorButton.isHidden = true
            endColorButton.isHidden = true
        } else {
            startColorButton.isHidden = false
            endColorButton.isHidden = false
        }
        
        updateWebView()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (pickerView == effectPicker) {
            effectName.text = effectPickerData[row]
        } else if (pickerView == fontPicker) {
            fontTextField.text = fontPickerData[row]
        }
    }

    @IBOutlet weak var pickerUIView: UIView!
    
    
    @IBOutlet weak var endColorButton: UIButton!
    @IBOutlet weak var startColorButton: UIButton!
    
    
    @IBOutlet weak var effectTextField: UITextField!
    @IBOutlet weak var fontTextField: UITextField!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var textEntryField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    
    func rgbToColorCode(r: Int, g: Int, b: Int) -> String {

        return "#" + String(format:"%2X", r) + String(format:"%2X", g) + String(format:"%2X", b)
    }
    
    func pickHex(c1:UIColor, c2:UIColor, weight:Double) -> [Int] {
        
        let color1 = c1.components
        let color2 = c2.components
        let p = weight
        let w = p * 2 - 1;
        let w1 = (w/1+1) / 2;
        let w2 = 1 - w1;
        let rgb = [Int(Double(color1.red*255) * w1 + Double(color2.red*255) * w2),
                   Int(Double(color1.green*255) * w1 + Double(color2.green*255) * w2),
                   Int(Double(color1.blue*255) * w1 + Double(color2.blue*255) * w2)];
        
        return rgb
    }

    func updateWebView() {
        var html_string = "<p style='font-family: \(fontTextField.text!); font-size: \(Int(sizeSlider.value))px; text-align:center'>"
        let str = textEntryField.text!
        
        //print("dank")
        //print(str)
        if (effectTextField.text == "Rainbow") {
            //html_string += str
            let frequency = 0.3;
            var i = 0
            var red = 0
            var green = 0
            var blue = 0
            
            for c in str.characters {
                
                let x = frequency * Double(i)
                red   = Int(sin(x + 0) * 127.0 + 128.0);
                green = Int(sin(x + 2) * 127.0 + 128);
                blue  = Int(sin(x + 4) * 127.0 + 128.0);
                
                let color = rgbToColorCode(r:red, g:green, b:blue)
                html_string += "<font color='\(color)'>\(c)</font>"
                
                i += 1
            }
            
            
            html_string += "</p>"
            
            
        } else if effectTextField.text == "Gradient" {
            
            let len = str.characters.count
            
            let startColor = startButtonColor.components
            let endColor = endButtonColor.components
            
            var red = 0.0
            var green = 0.0
            var blue = 0.0
            var alpha = 0.0
            for c in str.characters {
                alpha += (1.0/Double(len))
                
                red = Double(startColor.red)*alpha + (1-alpha)*Double(endColor.red)
                green = Double(startColor.green)*alpha + (1-alpha)*Double(endColor.green)
                blue = Double(startColor.blue)*alpha + (1-alpha)*Double(endColor.blue)
                
                //let color = rgbToColorCode(r: Int(red*255.0), g: Int(green*255.0), b: Int(blue*255.0))
                
                var result = pickHex(c1:startButtonColor, c2:endButtonColor, weight:alpha)
                let color = rgbToColorCode(r: result[0], g: result[1], b: result[2])
                html_string += "<font color='\(color)'>\(c)</font>"
            }
        } else if effectTextField.text == "Box" {
            
            html_string += "<table style='border-style:solid;'><tr><td width='30%'>"
            html_string += str
            html_string += "</td></tr></table>"
            
        }
        webView.loadHTMLString(html_string, baseURL:nil)
        
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        updateWebView()
        
    }
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sizeLabel.text = "Size: (\(round(sender.value)))"
        updateWebView()
    }
    
}

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
}

