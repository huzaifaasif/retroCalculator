//
//  ViewController.swift
//  retroCalc-finalAttempt
//

//  Copyright © 2017 Huzaifa Asif. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
   //-----variables
    @IBOutlet weak var screenLabel: UILabel!
    var runningNumber:String = ""
    var firstLabel:Bool = true
    var digit:Int=0
    
    var firstVal = ""
    var secondVal = ""
    var result = ""

    var btnSound:AVAudioPlayer!
    
    enum operation:String{
        case Add = "+"
        case Divide = "/"
        case Subtract = "-"
        case Multiply = "*"
        case Equals = "="
        case empty = ""
    }
    
    var currentOperation:operation = operation.empty
    
   
    //-------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundURL = NSURL.fileURL(withPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            
            btnSound.prepareToPlay()
        }
        catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        
        let operands = sender.tag
        
        switch (operands){
        case 10:
            processOperation(Oper: .Divide)
        case 20:
           processOperation(Oper: .Multiply)
        case 30:
            processOperation(Oper: .Subtract)
        case 40:
            processOperation(Oper: .Add)
        case 50:
            processOperation(Oper: .Equals)
            
        default: break
        }
    }
    
    
    
    @IBAction func numberPressed(sender: UIButton){
        
      
        digit = sender.tag      //int
        
        print("digit is: \(digit)\n")
        playSound()
        
        runningNumber+=String(digit)
        screenLabel.text = runningNumber
        
        if (currentOperation == operation.empty){
            firstVal = runningNumber
            
            print("--->first val: \(firstVal)")
        }
        else{
            
            secondVal = runningNumber
            print("--->second val: \(secondVal)")
            
        }
        
        
    }
    
    //operator actions
    
    
    
    func processOperation(Oper: operation){
        
        if (firstVal != ""){            //ensuring first value has been set
            
            runningNumber = ""
            screenLabel.text = ""
            
            currentOperation = Oper     //setting the current operation
          
            
        }
        
        print("--->Current Operation: \(Oper)")
        
    }
    

    @IBAction func result(_ sender: Any) {
    
        
        if (secondVal != ""){       //ensuring second value has been set prior to performing operations
            
            if (currentOperation == operation.Divide){
                result =  "\(Double(firstVal)! / Double(secondVal)!)"
            }
            else if (currentOperation == operation.Multiply){
                result = "\(Double(firstVal)! * Double(secondVal)!)"
            }
            
            else if (currentOperation == operation.Add){
                result = "\(Double(firstVal)! + Double(secondVal)!)"
            }
            else if (currentOperation == operation.Subtract){
                result = "\(Double(firstVal)! - Double(secondVal)!)"
            }
            
            
            screenLabel.text = result
            
            firstVal = result
            clear()
            
        }

        
    }
    
    func clear(){           //setting parameters to nil
        secondVal = ""
        result = ""
        currentOperation = operation.empty
    }
    
    @IBAction func clearButton(_ sender: Any) {
        screenLabel.text = ""
        firstVal = ""
        runningNumber = ""
        clear()
    }


    func playSound(){
        
        if (btnSound.isPlaying){
            btnSound.stop()
        }
        
        //btnSound.play()
        
    }
    
    
    

}

