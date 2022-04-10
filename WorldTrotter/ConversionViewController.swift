//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Hussein Anwar on 08/04/2022.
//

import UIKit

class ConversionViewController: UIViewController {
    //MARK: - Outlets
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    //MARK: - Properties
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateCelsiusLabel()
    }
    
    override func viewWillLayoutSubviews() {
        //        setGradientBackground()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        self.view.backgroundColor = randomBackgroundColor()
    }
    
    
    
    //MARK: - Methods

    func setGradientBackground() {
        let colorTop = UIColor(red: 250.0/255.0, green: 60/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 250.0/255.0, green: 80/255.0, blue: 50.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop,colorBottom]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
        
        
    }
    
    func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)}
    
    func randomBackgroundColor() -> UIColor {
        let r = randomCGFloat()
        let g = randomCGFloat()
        let b = randomCGFloat()
        
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    func updateCelsiusLabel(){
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    
    //MARK: - Actions
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
        
        if let text = textField.text, let value = Double(text){
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
      
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
}

