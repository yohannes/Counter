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
    
    var counter: Int!
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    // MARK: - IBAction Methods
    
    @IBAction func plusButtonDidTouch(sender: UIButton) {
        guard let validButtonTitle = self.plusButton.currentTitle else { return }
        self.processCounterWith(operator: validButtonTitle)
    }
    
    @IBAction func minusButtonDidTouch(sender: UIButton) {
        guard let validButtonTitle = self.minusButton.currentTitle else { return }
        self.processCounterWith(operator: validButtonTitle)
    }
    
    @IBAction func resetButtonDidTouch(sender: UILabel) {
        self.numberLabel.text = "0"
        self.counter = 0
        
        self.plusButton.enabled = true
        self.minusButton.enabled = true
    }
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.counter = 0
    }
    
    // MARK: - Helper Methods
    
    private func processCounterWith(operator operation: String) {
        self.counter = operation == "+" ? self.counter + 1 : self.counter - 1
        self.numberLabel.text = String(self.counter)
        
        if self.counter >= 999 {
            self.plusButton.enabled = false
            self.minusButton.enabled = true
        }
        else if self.counter <= -999 {
            self.minusButton.enabled = false
            self.plusButton.enabled = true
        }
        else {
            self.plusButton.enabled = true
            self.minusButton.enabled = true
        }
    }
}
