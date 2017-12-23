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

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 128
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            EggRating.titleLabelText = RemoteConfigValue.shared.string(for: .ratingTitleText)
            EggRating.descriptionLabelText = RemoteConfigValue.shared.string(for: .ratingMessageText)
            EggRating.delegate = self
            EggRating.promptRateUs(in: self)
        }
    }

}

extension FeedViewController: EggRatingDelegate {
    
    func didRate(rating rate: Double) {
        Analytics.logEvent("rate_button_pressed", parameters: nil)
        if rate >= EggRating.minRatingToAppStore {
            Analytics.logEvent("rate_high_score", parameters: nil)
        }
    }
    func didIgnoreToRate() {}
    func didRateOnAppStore() {}
    func didIgnoreToRateOnAppStore() {}

}

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedTableViewCell {
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
