//
//  ViewController.swift
//  FireFeed
//
//  Created by Somjintana K. on 14/12/2017.
//  Copyright © 2017 Nui.swift. All rights reserved.
//

import UIKit
import EggRating
import FirebaseAnalytics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        EggRating.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        EggRating.promptRateUs(in: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: EggRatingDelegate {
    
    func didRate(rating rate: Double) {
        if rate >= EggRating.minRatingToAppStore {
            Analytics.logEvent("rate_high_score", parameters: nil)
        }
    }
    func didIgnoreToRate() {}
    func didRateOnAppStore() {}
    func didIgnoreToRateOnAppStore() {}

}

