//
//  GameViewController.swift
//  Snake2.0
//
//  Created by Hector Barrios on 12/18/19.
//  Copyright © 2019 Barrios Programming. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
            if let scene = SKScene(fileNamed: "GameScene"),
                let color = UIColor(named: "darkGreen3"){

                view.allowsTransparency = true
                scene.backgroundColor = UIColor.clear
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .fill
                
                let gameScene = scene as! GameScene
                gameScene.gameViewController = self
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsPhysics = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
