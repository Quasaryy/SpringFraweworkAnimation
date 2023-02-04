//
//  ViewController.swift
//  SpringFraweworkAnimation
//
//  Created by Yury on 03.02.23.
//

import Spring

// MARK: Enum
enum AnimationNumber {
    case one, two
    
    mutating func switcher() {
        switch self {
        case .one:
            self = .two
        case .two:
            self = .one
        }
    }
}

class ViewController: UIViewController {
    
    // MARK: IB Otlets
    @IBOutlet var springButton: SpringButton!
    @IBOutlet var springLabel: SpringLabel!
    @IBOutlet var springView: SpringView!
    
    // MARK: Properties
    var number = AnimationNumber.one
    var animationName = Spring.getPresetsForAnimation()
    var curves = Spring.getPresetsForCurves()
    
    // MARK: IB Actions
    @IBAction func springButtonTapped(_ sender: SpringButton) {
        switch number {
        case .one:
            animateObject(springableObject: sender)
            animateObject(springableObject: springView)
            number.switcher()
        case .two:
            animateObject(springableObject: sender)
            animateObject(springableObject: springView)
            number.switcher()
        }
    }
    
}

// MARK: Private Methods
extension ViewController {
    private func animateObject<T>(springableObject: T) where T: Springable {
        let duration = CGFloat.random(in: 0...2)
        let roundedDuration = String(format: "%.2f", duration)
        let animation: String! = animationName.shuffled().first
        let curve: String! = curves.shuffled().first
        
        springButton.setTitle("Next Animation", for: .normal)
        
        springableObject.animation = animation
        springableObject.curve = curve
        springableObject.duration = duration
        springLabel.text =
"""
View Animation Properties:

animation name: \(animation!)
curve: \(curve!)
duratation: \(roundedDuration)
"""
        springableObject.animate()
    }
    
}
// MARK: Spring Extensions
extension Spring {
    static func getPresetsForAnimation() -> [String] {
        var presets = [String]()
        for preset in Spring.AnimationPreset.allCases {
            presets.append(preset.rawValue)
        }
        return presets
    }
    
    static func getPresetsForCurves() -> [String] {
        var presets = [String]()
        for preset in Spring.AnimationCurve.allCases {
            presets.append(preset.rawValue)
        }
        return presets
    }
}

extension Spring.AnimationPreset: CaseIterable {
    public static var allCases: [Spring.AnimationPreset] {
        return [.Squeeze, .ZoomIn, .FadeInDown, .Morph, .FlipX, .Shake, .Swing, .Wobble, .Pop, .SlideDown, .SlideRight, .SlideUp, .SlideLeft]
    }
}

extension Spring.AnimationCurve: CaseIterable {
    public static var allCases: [Spring.AnimationCurve] {
        return [.EaseInBack, .EaseOut, .EaseIn, .EaseInBack, .EaseInOut, .Spring, .EaseInQuad, .EaseInQuart]
    }
}
