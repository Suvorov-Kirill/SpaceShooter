//
//  MainMenu.swift
//  SpaceShooter
//
//  Created by Кирилл Суворов on 26.07.2023.
//

import SpriteKit

class MainMenu: SKScene {
    var starfield:SKEmitterNode!
    
    var newGameBtnNode:SKSpriteNode!
    var levelBtnNode:SKSpriteNode!
    var labelLevelNode:SKLabelNode!
    
    override func didMove(to view: SKView) {
        starfield = (self.childNode(withName: "starfield") as! SKEmitterNode)
        starfield.advanceSimulationTime(10)
        
        newGameBtnNode = (self.childNode(withName: "NewGameBtn") as! SKSpriteNode)
        
        newGameBtnNode.texture = SKTexture(imageNamed: "newGameBtn")
        
        levelBtnNode = (self.childNode(withName: "testlevelBtn") as! SKSpriteNode)
        
        levelBtnNode.texture = SKTexture(imageNamed: "levelBtn")
        
        labelLevelNode = (self.childNode(withName: "LabelLevelBtn") as! SKLabelNode)
        
        let userLevel = UserDefaults.standard
        
        if userLevel.bool(forKey: "Hard"){
            labelLevelNode.text = "Hard"
        } else {
            labelLevelNode.text = "Easy"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "NewGameBtn" {
                let transition = SKTransition.flipVertical(withDuration: 0.5)
                let gameScene = GameScene(size: UIScreen.main.bounds.size)
                self.view?.presentScene(gameScene, transition: transition)
            } else if nodesArray.first?.name == "testlevelBtn" {
                changeLevel()
            }
        }
    }
    
    func changeLevel(){
        let userLevel = UserDefaults.standard
        
        if labelLevelNode.text == "Easy" {
            labelLevelNode.text = "Hard"
            userLevel.set(true, forKey: "Hard")
        } else {
            labelLevelNode.text = "Easy"
            userLevel.set(false, forKey: "Hard")
        }
        userLevel.synchronize()
    }
    
}
