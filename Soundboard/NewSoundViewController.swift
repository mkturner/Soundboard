//
//  NewSoundViewController.swift
//  Soundboard
//
//  Created by Marvin T. on 6/7/15.
//  Copyright (c) 2015 Marvin Turner. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class NewSoundViewController: UIViewController {
    
    required init(coder aDecoder: NSCoder){
        var baseString: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        var pathComponents = [baseString, "MyAudio.m4a"]
        self.audioURL = NSURL.fileURLWithPathComponents(pathComponents)!
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings: [NSObject: AnyObject] = Dictionary()
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        recordSettings[AVSampleRateKey] = 44100.0
        recordSettings[AVNumberOfChannelsKey] = 2
        
        self.audioRecorder = AVAudioRecorder(URL: self.audioURL, settings: recordSettings, error: nil)
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord()
        
        // super.init is below
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var soundNameField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    

    var audioRecorder: AVAudioRecorder
    var audioURL: NSURL
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
        newSound.URL = self.audioURL
        
        // add sound to sounds array
        self.previousViewController.sounds.append(newSound)
        
        //dismiss view controller
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func recordTapped(sender: AnyObject) {
        if self.audioRecorder.recording {
            self.audioRecorder.stop()
            self.recordButton.setTitle("Record", forState: UIControlState.Normal)
        } else {
            var session = AVAudioSession.sharedInstance()
            session.setActive(true, error: nil)
            self.audioRecorder.record()
            self.recordButton.setTitle("Finish Recording", forState: UIControlState.Normal)
        }
    }
}
