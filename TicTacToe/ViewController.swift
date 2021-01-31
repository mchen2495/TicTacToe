//
//  ViewController.swift
//  TicTacToe
//
//  Created by Michael Chen on 6/30/20.
//  Copyright © 2020 Michael Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var playAgainButton: UIButton!
    
    //reset the game to play again
    @IBAction func playAgain(_ sender: Any) {
        
        activeGame = true
        
        activePlayer = 1
        
        gameState = [0,0,0,0,0,0,0,0,0]
        
        /*find views with tags 1 to 9 (which are the buttons) and cast them to UIButton and
          set their images to be empty
         */
        for i in 1..<10 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
        
        winnerLabel.isHidden = true
        playAgainButton.isHidden = true
        
        //move the winner label and play again button off of the screen
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
    }
    
    var activeGame = true
    
    //1 is circles/noughts, 2 is crosses
    var activePlayer = 1
    
    //0 means spot is empty empty, 1 means circle , 2 mean cross
    var gameState = [0,0,0,0,0,0,0,0,0]
    
    //horizontal, vertical, and diagonal winning position combination
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        winnerLabel.isHidden = true
        playAgainButton.isHidden = true
        
        //move the winner label and play again button off of the screen
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
        
    }
    
    
    
    /*All nine buttons are connected to this IB Action, use the Tag property
      set in the attribute window to figure out which button was pressed
     */
    @IBAction func buttonPress(_ sender: UIButton) {
        
        //setting up index for gameStats array
        let activePosition = sender.tag - 1
        
        //if the spot on the grid is not taken than a player can place their shape there
        if gameState[activePosition] == 0  && activeGame {
            
            //set grid position to be represent by active player
            gameState[activePosition] = activePlayer
            
            if activePlayer == 1 {
                
                //setting image of the button, use [] to set default state
                sender.setImage(UIImage(named: "nought.png"), for: [])
                
                //make it player two's turn
                activePlayer = 2
                
            }
            
            else {
                //setting image of the button, use [] to set default state
                sender.setImage(UIImage(named: "cross.png"), for: [])
                
                //make it player one's turn
                activePlayer = 1
            }
            
            
            for combination in winningCombinations{
                
                /*Checking the game state of the first position inside
                 of the arrays inside winningCombination to see that it's
                 not 0. Winning occurs when all the position in winning postion
                 is 1s or 2s
                 
                 combination refers to [0,1,2] ......
                 so combination[0] refers to position 0, (first)
                 combination[1] refers to postion 1,  (second)
                 combination[1] refers to postion 2  (third)
                 
                 we check that first one is not zero, than we check if second is equal to first
                 and if third is equal to first. If all is true that mean same shape is in the position
                 so we have a winner
                 
                 */
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] &&
                    gameState[combination[1]] == gameState[combination[2]]{
                    
                    //We have a winner!
                    activeGame = false
                    winnerLabel.isHidden = false
                    playAgainButton.isHidden = false
                    
                    if gameState[combination[0]] == 1 {
                        
                        winnerLabel.text = "Circles has won!"
                    }
                    else {
                        winnerLabel.text = "Crosses has won!"
                    }
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        //bring/animate the winner label back on the screen
                        self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
                        
                        self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x + 500, y: self.playAgainButton.center.y)
                    })
                    
                }
                
            }
            
            
        }
        
        
    }
    
    



}

