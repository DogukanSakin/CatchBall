//
//  ViewController.swift
//  CatchBall
//
//  Created by DOGUKAN on 16.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var score:Int?;
    var highScore:Int?;
    var time:Int?;
    var timer = Timer()
    var isGameOver = false;

    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var ball: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        
    }
    
    func startGame() {
        score = 0
        time = 30
        isGameOver = false
        timeLabel.text = "Time: \(time!)"
        scoreLabel.text = "\(score!)"
        
        highScore = UserDefaults.standard.object(forKey: "highScore") as? Int ?? 0
        highScoreLabel.text = "High Score: \(highScore!)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementTime), userInfo: nil, repeats: true)
        
        ball.isUserInteractionEnabled = true
        ball.contentMode = .scaleAspectFit
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBall))
        
        ball.addGestureRecognizer(gestureRecognizer)
        
        changeBallLocation();
    }
    
    
    
    @objc func decrementTime(){
        if(time! <= 0){
            time = 0;
            timeLabel.text = "Game Over!"
            
            isGameOver = true
            
            UserDefaults.standard.set(highScore, forKey: "highScore")
            
            let alertController = UIAlertController(title: "Game Over!", message: "Game is over. Do you want play again?", preferredStyle: UIAlertController.Style.alert)
            
            let playAgainButton = UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default) { _ in
                self.startGame()
            }
          
            
            alertController.addAction(playAgainButton)
            
            timer.invalidate()
            
            return present(alertController, animated: true)
        }
        
        timeLabel.text = "Time: \(time!)"
        time! -= 1
     
        
    }
    
    @objc func didTapBall(){
        if isGameOver {
            return
        }
        
        score! += 1
        scoreLabel.text = "\(score!)"
        
        if(score! > highScore!){
            highScore = score;
            highScoreLabel.text = "High Score: \(highScore!)"
        }
        
        changeBallLocation();
    }
    
    func changeBallLocation(){
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        
        let randomX = CGFloat.random(in: 0...(screenWidth - ball.frame.width))
        let randomY = CGFloat.random(in: (screenHeight / 4)...(screenHeight - ball.frame.height))
        
        
        ball.frame.origin = CGPoint(x: randomX, y: randomY)
        
        
    }
    



}

