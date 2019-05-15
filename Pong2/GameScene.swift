//
//  GameScene.swift
//  Pong
//
//  Created by SHAIL PATEL on 2/27/19.
//  Copyright © 2019 SHAIL PATEL. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var player = SKSpriteNode()
    var topS = SKLabelNode()
    var bottomS = SKLabelNode()
    var increase = 0.0
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        //startGame()
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        player = self.childNode(withName: "player") as! SKSpriteNode
        topS = self.childNode(withName: "topS") as! SKLabelNode
        bottomS = self.childNode(withName: "bottomS") as! SKLabelNode
        ball.physicsBody?.applyImpulse(CGVector(dx: 2 , dy: 20))
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        startGame()
        increaseSpeed()
        
    }
    
    func startGame()  {
        score = [0,0]
        
        topS.text = "\(score[1])"
        bottomS.text =  "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 2 , dy: 20))
        
    }
    func increaseSpeed ()
    {
        if (score[0] > 1)
        {
            increase+=1
        }
        else if (score[0] > 7)
        {
            increase+=0.001
        }
        else if (score[0] > 9)
        {
            increase+=0.001
        }
        else if (score[0] > 15)
        {
            increase+=0.001
        }
    }
    
    func addScore(playerWhoWon: SKSpriteNode)  {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
        
        if playerWhoWon == player{
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20 , dy: 20))
            
        }
        else if playerWhoWon == enemy {
            
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: Int.random(in: -20...0) , dy: Int.random(in: -20 ... -15)))
        }
        print(score)
        topS.text = "\(score[1])"
        bottomS.text =  "\(score[0])"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            //player.run(SKAction.moveTo(x: location.x, duration: 0.2))
            if currentGameType == .player2{
                
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2+increase))
                    
                }
                if location.y < 0 {
                    player.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else{
                player.run(SKAction.moveTo(x: location.x, duration: 0.2))
                
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if currentGameType == .player2{
                
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2+increase))
                    
                }
                if location.y < 0 {
                    player.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else{
                player.run(SKAction.moveTo(x: location.x, duration: 0.2))
                
            }
            
            
            //player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        switch currentGameType {
        case .easy:
            
            enemy.run(SKAction.moveTo(x: ball.position.x-100, duration: 0.5+increase))
            break
            
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x-100, duration: 0.3+increase))
            
            break
            
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x-100, duration: 0.1+increase))
            
            break
            
        case .player2:
            
            
            break
        
        }
        
      
        
        
        if ball.position.y <= player.position.y - 1  {
            
            addScore(playerWhoWon: enemy)
            
        }
        else if ball.position.y >= enemy.position.y + 1 {
            addScore(playerWhoWon: player)
        }
        
        
    }
    
}

