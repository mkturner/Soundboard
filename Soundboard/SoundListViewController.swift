//
//  SoundListViewController.swift
//  Soundboard
//
//  Created by Marvin T. on 6/6/15.
//  Copyright (c) 2015 Marvin Turner. All rights reserved.
//

import UIKit
import AVFoundation

class SoundListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    // tells tableView how many rows to have
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // tells tableView what's in each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create row object (cell)
        var cell = UITableViewCell()
        // assign value to cell
        cell.textLabel!.text = "BRUH"
        // send cell back to view
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // find location of playable media
        var soundPath = NSBundle.mainBundle().pathForResource("bruh", ofType: "m4a")
        // convert location info into usable URL
        var soundURL = NSURL.fileURLWithPath(soundPath!)
        // assign URL to audio player
        self.audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        // Play file at the assigned URL
        self.audioPlayer.play()
    }
    
}

