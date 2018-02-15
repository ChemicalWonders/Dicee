//
//  ViewController.swift
//  Dicee
//
//  Created by Kevin Chan on 2/11/18.
//  Copyright © 2018 Kevin Chan. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    var randomDiceIndex1 : Int = 0
    var randomDiceIndex2 : Int = 0
    
    var diceRollSoundEffect: AVAudioPlayer = AVAudioPlayer()
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let musicFile = Bundle.main.path(forResource: "diceRoll", ofType: ".wav")
        
        do {
            try(diceRollSoundEffect = AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile!)))
        }
        catch {
            print(error)
        }
        
        updateDiceImagesWithoutVibration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        updateDiceImages()
    }
    
    func playDiceRollSound(){
        diceRollSoundEffect.stop()
        diceRollSoundEffect.play()
    }
    
    func updateDiceImagesWithoutVibration(){
        randomDiceIndex1 = Int(arc4random_uniform(6))
        randomDiceIndex2 = Int(arc4random_uniform(6))
        
        diceImageView1.image = UIImage(named: diceArray[randomDiceIndex1])
        diceImageView2.image = UIImage(named: diceArray[randomDiceIndex2])
    }

    func updateDiceImages(){
        //playDiceRollSound()
        
        //For Vibration
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        updateDiceImagesWithoutVibration()
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
}

