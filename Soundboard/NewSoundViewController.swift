//
//  NewSoundViewController.swift
//  Soundboard
//
//  Created by Marvin T. on 6/7/15.
//  Copyright (c) 2015 Marvin Turner. All rights reserved.
//

import Foundation
import UIKit

class NewSoundViewController: UIViewController {
    
    @IBOutlet weak var soundNameField: UITextField!
    
    var previousViewController = SoundListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // do necessary setup after loading the view
    }
    
    @IBAction func cancelTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveTapped(sender: UIBarButtonItem) {
        // TODO: Hook up to new controller
        // create a sound
        var newSound = Sound()
        newSound.name = self.soundNameField.text!
        
        // add sound to sounds array
        self.previousViewController.sounds.append(newSound)
        
        //dismiss view controller
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
