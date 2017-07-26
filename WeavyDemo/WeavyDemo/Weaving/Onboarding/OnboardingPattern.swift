//
//  OnboardingPattern.swift
//  WeavyDemo
//
//  Created by Thibault Wittemberg on 17-08-09.
//  Copyright © 2017 Warp Factor. All rights reserved.
//

import Foundation
import Weavy

class OnboardingPattern: Patternable {

    let initialWarp: Warp
    let initialWeft: Weft
    var woolBag: WoolBag

    init(withInitialWarp warp: DemoWarp, withInitialWeft weft: DemoWeft, withWoolBag woolBag: OnboardingWoolBag) {
        self.initialWarp = warp
        self.initialWeft = weft
        self.woolBag = woolBag
    }

    func knit(fromWarp warp: Warp, fromWeft weft: Weft, withWoolBag woolBag: WoolBag) -> Stitch {

        guard   let demoWarp = warp as? DemoWarp,
                demoWarp == DemoWarp.onboarding,
                let demoWeft = weft as? DemoWeft,
                let onboardingWoolBag = woolBag as? OnboardingWoolBag else { return Stitch.void }

        switch demoWeft {
        case .bootstrap:
            let navigationViewController = UINavigationController()
            return Stitch(withPresentationStyle: .none, withPresentable: navigationViewController, withWeftable: OnboardingWeftable())
        case .needToOnboard:
            let viewController = OnboardViewController1.instantiate()
            return Stitch(withPresentationStyle: .show, withPresentable: viewController, withWeftable: viewController)
        case .welcomeComplete:
            let viewController = OnboardViewController2.instantiate()
            return Stitch(withPresentationStyle: .show, withPresentable: viewController, withWeftable: viewController)
        case .serverComplete:
            let viewController = OnboardViewController3.instantiate()
            return Stitch(withPresentationStyle: .show, withPresentable: viewController, withWeftable: viewController)
        case .loginComplete:
            return Stitch.end
        default:
            return Stitch.void
        }
    }
}
