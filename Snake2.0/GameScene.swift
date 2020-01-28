//
//  GameScene.swift
//  Snake2.0
//
//  Created by Hector Barrios on 12/18/19.
//  Copyright © 2019 Barrios Programming. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameViewController: GameViewController?

    private var scoreBackButton: SKLabelNode?
    private var pauseResumeButton: SKLabelNode?
    private var playButton: SKLabelNode?
    private var node: SKShapeNode?
    
    /*String used to locate nodes and also change the text on each labelnode*/
    private let scoreBackName = "scoreBack"
    private let pauseRestartName = "pauseRestart"
    private let startResumeName = "startResume"
    private let back = "Back"
    private let restart = "Restart"
    private let resume = "Resume"
    private let start = "Start"
    private let pause = "Pause"
    private let score = "Score:"
    
    private var playing: Bool?
    
    private let directionValue = 200
    private var direction: CGVector?
    
    
    override func didMove(to view: SKView) {
        playing = false
        self.anchorPoint = CGPoint.zero
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeDirection(sender:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeDirection(sender:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeDirection(sender:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipeDirection(sender:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        
        let scoreBackButton = SKLabelNode(text: back)
        scoreBackButton.name = scoreBackName
        scoreBackButton.fontName = "lilitaone"
        scoreBackButton.color = UIColor.white
        scoreBackButton.fontSize = 42
        scoreBackButton.position = CGPoint(x: self.size.width/7, y: self.size.height - 110)
        scoreBackButton.horizontalAlignmentMode = .left
        scoreBackButton.isUserInteractionEnabled = false
        self.addChild(scoreBackButton)
        
        let pauseResumeButton = SKLabelNode(text: pause)
        pauseResumeButton.name = pauseRestartName
        pauseResumeButton.fontName = "lilitaone"
        pauseResumeButton.color = UIColor.white
        pauseResumeButton.fontSize = 42
        pauseResumeButton.alpha = 0
        pauseResumeButton.position = CGPoint(x: (self.size.width/7) * 6, y: self.size.height - 110)
        pauseResumeButton.horizontalAlignmentMode = .right
        pauseResumeButton.isUserInteractionEnabled = false
        self.addChild(pauseResumeButton)
        
        let button3 = SKLabelNode(text: start)
        button3.fontName = "lilitaone"
        button3.name = startResumeName
        button3.color = UIColor.white
        button3.fontSize = 96
        button3.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        button3.isUserInteractionEnabled = false
        self.addChild(button3)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    
    
    /*
     This is where all the logic on how to handle each label whenever it's clicked so that we can start, pause, or restart the game.
 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self),
            let fadeOutSlow = SKAction(named: "Fade OutSlow"),
            let fadeOutFast = SKAction(named: "Fade OutFast"),
            let fadeOut = SKAction(named: "Fade Out"),
            let fadeInSlow = SKAction(named: "Fade InSlow"),
            let fadeInFast = SKAction(named: "Fade InFast"),
            let fadeIn = SKAction(named: "Fade In"),
            let pauseRestartButton = self.childNode(withName: pauseRestartName) as? SKLabelNode,
            let scoreBackButton = self.childNode(withName: scoreBackName) as? SKLabelNode,
            let startResumeButton = self.childNode(withName: startResumeName) as? SKLabelNode
            else { return }
        
        let node = atPoint(location)
        
        switch(node.name)
        {
        case scoreBackName:
            if(scoreBackButton.text == back)
            {
                gameViewController!.dismiss(animated: true, completion: nil)
            }

        case pauseRestartName:
            pauseGame()
            scoreBackButton.run(fadeOut)
            {
                scoreBackButton.text = scoreBackButton.text != self.back ? self.back : "\(self.score) 0"
                scoreBackButton.run(fadeIn)
            }
            
            pauseRestartButton.run(fadeOut)
            {
                pauseRestartButton.text = pauseRestartButton.text == self.pause ? self.restart : self.pause
                pauseRestartButton.run(fadeIn)
            }
            
            if(startResumeButton.alpha == 0.0)
            {
                startResumeButton.text = self.resume
                startResumeButton.run(fadeInSlow)
            }
            else
            {
                startResumeButton.run(fadeOutSlow)
                {
                    self.restartGame()
                }
            }
            
        case startResumeName:
            
            if(startResumeButton.text == resume)
            {
                startResumeButton.run(fadeOutSlow)
                {
                    self.resumeGame()
                }
                
                scoreBackButton.run(fadeOut)
                {
                    scoreBackButton.text = "\(self.score) 0"
                    scoreBackButton.run(fadeIn)
                }
                
                pauseRestartButton.run(fadeOut)
                {
                    pauseRestartButton.text = self.pause
                    pauseRestartButton.run(fadeIn)
                }
            }
            else
            {
                startResumeButton.run(fadeOutSlow)
                {
                    self.moveNode()
                }
                
                pauseRestartButton.run(fadeOut)
                {
                    pauseRestartButton.run(fadeIn)
                }
                
                scoreBackButton.run(fadeOut)
                {
                    scoreBackButton.text = "\(self.score) 0"
                    scoreBackButton.run(fadeIn)
                }
            }

        default:
            break
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.count)
        for t in touches {
                print(t.location(in: self))
            self.touchUp(atPoint: t.location(in: self))
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    
    @objc private func swipeDirection(sender: UISwipeGestureRecognizer)
    {
        
        if let playing = playing, playing
        {
            switch sender.direction
            {
            case .up:
                direction = CGVector(dx: 0, dy: directionValue)
            case .down:
                direction = CGVector(dx: 0, dy: -directionValue)
            case .left:
                direction = CGVector(dx: -directionValue, dy: 0)
            case .right:
                direction = CGVector(dx: directionValue, dy: 0)
            default:
                break
            }
            
            changeDirection()
        }

    }
    
    func changeDirection()
    {
        guard let node = node,
        let direction = direction else { return }
        
        node.removeAllActions()
        let action = SKAction.repeatForever(SKAction.move(by: direction, duration: 2))
        node.run(action)
        
    }
    
    func moveNode()
    {
        playing = true
        node = SKShapeNode(rect: CGRect(x: self.size.width / 2, y: self.size.height / 2, width: 50, height: 50))
        node?.fillColor = UIColor(named: "darkRed5")!
        self.addChild(node!)
        let number = GKARC4RandomSource().nextInt(upperBound: 4)
        switch number
        {
        case 0:
            direction = CGVector(dx: 0, dy: directionValue)
        case 1:
            direction = CGVector(dx: 0, dy: -directionValue)
        case 2:
            direction = CGVector(dx: -directionValue, dy: 0)
        case 3:
            direction = CGVector(dx: directionValue, dy: 0)
        default:
            break
        }
        let action = SKAction.repeatForever(SKAction.move(by: direction!, duration: 2))
        node?.run(action)
        {
            self.node?.fillColor = UIColor.green
        }
        
    }
    
    func pauseGame()
    {
        guard let node = node else { return }
        playing = false
        node.removeAllActions()
    }
    
    func resumeGame()
    {
        guard let node = node,
        let direction = direction else { return }
        let action = SKAction.repeatForever(SKAction.move(by: direction, duration: 2))
        node.run(action)
        playing = true
    }
    
    func restartGame()
    {
        guard let node = node else { return }
        self.removeChildren(in: [node])
        moveNode()
    }
    
}
