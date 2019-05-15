//
//  Menu.swift
//  Pong2
//
//  Created by SHAIL PATEL on 5/7/19.
//  Copyright © 2019 SHAIL PATEL. All rights reserved.
//

import Foundation

import UIKit
enum gameType {
    case easy
    case medium
    case hard
    case player2
}
class Menu: UIViewController {
    
    @IBAction func easy(_ sender: UIButton) {
        moveToGame(game: .easy)
    }
  
    @IBAction func medium(_ sender: UIButton) {
        moveToGame(game: .medium)
    }
    
    @IBAction func hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    @IBAction func v2(_ sender: UIButton) {
        moveToGame(game: .player2)
    }
    
    
    func moveToGame(game: gameType)  {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
        
    }
    
}
