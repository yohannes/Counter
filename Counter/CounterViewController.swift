//
//  CounterViewController.swift
//  Counter
//
//  Created by Yohannes Wijaya on 8/2/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//


// TODO: 1) change icon background to transparent. 2) when user tap and hold on either + / -, counter will keep incrementing/decrementing until touch up. 3) set max to 999 and min to -999
import UIKit

class CounterViewController: UIViewController {
    
    // MARK: - Stored Properties
    
    var counter: Int!
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    // MARK: - IBAction Methods
    
    @IBAction func plusButtonDidTouch(_ sender: UIButton) {
        guard let validButtonTitle = self.plusButton.currentTitle else { return }
        self.processCounterWith(operator: validButtonTitle)
    }
    
    @IBAction func minusButtonDidTouch(_ sender: UIButton) {
        guard let validButtonTitle = self.minusButton.currentTitle else { return }
        self.processCounterWith(operator: validButtonTitle)
    }
    
    @IBAction func resetButtonDidTouch(_ sender: UILabel) {
        self.numberLabel.text = "0"
        self.counter = 0
        
        self.plusButton.isEnabled = true
        self.minusButton.isEnabled = true
    }
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.counter = 0
    }
    
    // MARK: - Helper Methods
    
    fileprivate func processCounterWith(operator operation: String) {
        self.counter = operation == "+" ? self.counter + 1 : self.counter - 1
        self.numberLabel.text = String(self.counter)
        
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
