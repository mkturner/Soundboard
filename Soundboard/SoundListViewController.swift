//
//  SoundListViewController.swift
//  Soundboard
//
//  Created by Marvin T. on 6/6/15.
//  Copyright (c) 2015 Marvin Turner. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class SoundListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // instantiate AVAudioPlayer for later use
    var audioPlayer = AVAudioPlayer()
    
    // array to hold al the sounds
    var sounds: [Sound] = []
    
    func findURL (name: String, ofType: String) -> NSURL {
        // find location of playable media
        var filePath = NSBundle.mainBundle().pathForResource(name, ofType: ofType)
        // convert location info into usable URL
        var fileURL = NSURL.fileURLWithPath(filePath!)
        // send URL back to calling scope
        return fileURL!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // append a sound to 'sounds' array for test
//        var newSound = Sound()
//        newSound.name = "'BRUH' impression"
//        newSound.URL = findURL("bruh", ofType: "m4a")
//        self.sounds.append(newSound)
        
        // find context of application/app delegate for Core Data
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        // create new Core Data object
        var newSound = NSEntityDescription.insertNewObjectForEntityForName("Sound", inManagedObjectContext: context) as! Sound
        // add properties to created Core Data object
        newSound.name = "'BRUH' impression"
        newSound.url = findURL("bruh", ofType: "m4a").absoluteString!
        
        // save object to CoreData
        context.save(nil)
        
        // get all records from core data
        //------
        // make a request for sound objects
        var request = NSFetchRequest(entityName: "Sound")
        // use request to pull objects into sounds array
        self.sounds = context.executeFetchRequest(request, error: nil) as! [Sound]
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    // tells tableView how many rows to have
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // make a cell for each item in the array
        return self.sounds.count
    }
    
    // tells tableView what's in each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var currentSound = self.sounds[indexPath.row]
        // create row object (cell)
        var cell = UITableViewCell()
        // assign value to cell
        cell.textLabel!.text = currentSound.name
        // send cell back to view
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // find location of playable media & return info as usable URL
//        var soundURL = self.sounds[indexPath.row].URL
        // assign URL to audio player
//        self.audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        // Play file at the assigned URL
        self.audioPlayer.play()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nextViewControler = segue.destinationViewController as! NewSoundViewController
        nextViewControler.previousViewController = self
    }
    
}

