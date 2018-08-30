//
//  Protocol.swift
//  Counter
//
//  Created by Yohannes Wijaya on 8/28/18.
//  Copyright © 2018 Yohannes Wijaya. All rights reserved.
//

import UIKit
import AudioToolbox

enum Taptic: UInt32 {
    case Peek = 1519
    case Pop = 1520
    case Nope = 1521
}

protocol Vibratable {
    var tapticLevel: Int { get }
    func vibrateDevice(forHigherThan6s: UIImpactFeedbackStyle, for6s: Taptic, lowerThan6s: SystemSoundID)
}

extension Vibratable {
    var tapticLevel: Int {
        return UIDevice.current.value(forKey: "_feedbackSupportLevel") as! Int
    }
    func vibrateDevice(forHigherThan6s: UIImpactFeedbackStyle = .medium, for6s: Taptic = .Peek, lowerThan6s: SystemSoundID = kSystemSoundID_Vibrate) {
        switch tapticLevel {
        case 2:
            let generator = UIImpactFeedbackGenerator(style: forHigherThan6s)
            generator.prepare()
            generator.impactOccurred()
        case 1:
            AudioServicesPlaySystemSound(for6s.rawValue)
        default:
            AudioServicesPlaySystemSound(lowerThan6s)
        }
    }
}
