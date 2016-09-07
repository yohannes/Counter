//
//  CounterViewController.swift
//  Counter
//
//  Created by Yohannes Wijaya on 8/2/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {
    
    // MARK: - Stored Properties
    
    var counter = 0
    let firingInterval = 0.1
    
    var timer: Timer?
    
    var plusButtonTitle: String!
    var minusButtonTitle: String!
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    // MARK: - IBAction Methods
    
    @IBAction func plusButtonDidTouch(_ sender: UIButton) {
        self.processCounterWith(operator: self.plusButtonTitle)
    }
    
    @IBAction func minusButtonDidTouch(_ sender: UIButton) {
        self.processCounterWith(operator: self.minusButtonTitle)
    }
    
    @IBAction func resetButtonDidTouch(_ sender: UILabel) {
        self.numberLabel.text = "0"
        self.counter = 0
        
        self.plusButton.isEnabled = true
        self.minusButton.isEnabled = true
    }
    
    @IBAction func minusButtonDidLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            self.timer = Timer.scheduledTimer(timeInterval: self.firingInterval, target: self, selector: #selector(CounterViewController.decrementCounter), userInfo: nil, repeats: true)
        }
        else if sender.state == .ended || sender.state == .cancelled {
            self.timer?.invalidate()
            self.timer = nil
            
            self.minusButton.isHighlighted = false
        }
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let validPlusbuttonTitle = self.plusButton.currentTitle else { return }
        self.plusButtonTitle = validPlusbuttonTitle
        
        guard let validMinusButtonTitle = self.minusButton.currentTitle else { return }
        self.minusButtonTitle = validMinusButtonTitle
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(CounterViewController.plusButtonDidLongPress(sender:)))
        longPressGestureRecognizer.minimumPressDuration = 0.25
        self.plusButton.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    // MARK: - Helper Methods
    
    @objc fileprivate func incrementCounter() {
        self.counter = self.counter + 1
        self.numberLabel.text = String(self.counter)
        
        self.plusButton.isHighlighted = true
        
        self.toggleButtonsState()
    }
    
    @objc fileprivate func decrementCounter() {
        self.counter  = self.counter - 1
        self.numberLabel.text = String(self.counter)
        
        self.minusButton.isHighlighted = true
        
        self.toggleButtonsState()
        
    }
    
    @objc fileprivate func processCounterWith(operator operation: String) {
        self.counter = operation == "+" ? self.counter + 1 : self.counter - 1
        self.numberLabel.text = String(self.counter)
        
        self.toggleButtonsState()
    }
    
    @objc fileprivate func plusButtonDidLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            self.timer = Timer.scheduledTimer(timeInterval: self.firingInterval, target: self, selector: #selector(CounterViewController.incrementCounter), userInfo: nil, repeats: true)
        }
        else if sender.state == .ended || sender.state == .cancelled {
            self.timer?.invalidate()
            self.timer = nil
            
            self.plusButton.isHighlighted = false
        }
    }
    
    fileprivate func toggleButtonsState() {
        if self.counter >= 999 {
            self.plusButton.isEnabled = false
            self.minusButton.isEnabled = true
        }
        else if self.counter <= -999 {
            self.minusButton.isEnabled = false
            self.plusButton.isEnabled = true
        }
        else {
            self.plusButton.isEnabled = true
            self.minusButton.isEnabled = true
        }
    }
}
