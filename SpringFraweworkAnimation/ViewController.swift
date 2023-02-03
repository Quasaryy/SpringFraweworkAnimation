//
//  ViewController.swift
//  SpringFraweworkAnimation
//
//  Created by Yury on 03.02.23.
//

import Spring

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
    
    @IBOutlet var springButton: SpringButton!
    @IBOutlet var springLabel: SpringLabel!
    @IBOutlet var springView: SpringView!
    
    var number = AnimationNumber.one
    var animationName = Spring.getPresetsForAnimation()
    var curves = Spring.getPresetsForCurves()
    
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

extension Spring {
    static func getPresetsForAnimation() -> [String] {
        return ["slideLeft",
                "slideRight",
                "slideDown",
                "slideUp",
                "squeezeLeft",
                "squeezeRight",
                "squeezeDown",
                "squeezeUp",
                "fadeOutIn",
                "fadeInLeft",
                "fadeInRight",
                "fadeInDown",
                "fadeInUp",
                "shake",
                "pop",
                "flipX",
                "flipY",
                "morph",
                "squeeze",
                "flash",
                "wobble",
                "swing"]
    }
    
    static func getPresetsForCurves() -> [String] {
        return ["easeIn",
                "easeOut",
                "easeInOut",
                "linear",
                "spring",
                "easeInSine",
                "easeOutSine",
                "easeInOutSine",
                "easeInQuad",
                "easeOutQuad",
                "easeInOutQuad",
                "easeInCubic",
                "easeOutCubic",
                "easeInOutCubic",
                "easeInQuart",
                "easeOutQuart"]
    }
}
