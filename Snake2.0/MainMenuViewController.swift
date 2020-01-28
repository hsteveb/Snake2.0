//
//  MainMenuViewController.swift
//  Snake2.0
//
//  Created by Hector Barrios on 12/18/19.
//  Copyright © 2019 Barrios Programming. All rights reserved.
//

import UIKit
import AVFoundation

var music: AVAudioPlayer?



class MainMenuViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let path = Bundle.main.path(forResource: "RainbowGlow.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do
        {
            music = try AVAudioPlayer(contentsOf: url)
            music?.play()
        }
        catch
        {
            
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func unwindTemp(segue: UIStoryboardSegue)
    {
        
    }
}
