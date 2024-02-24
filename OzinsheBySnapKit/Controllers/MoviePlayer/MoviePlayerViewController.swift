//
//  MoviePlayerViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 23.02.2024.
//

import UIKit
import YouTubePlayer

class MoviePlayerViewController: UIViewController {
    
    var player = YouTubePlayerView()
    var video_link = ""

   override func viewDidLoad() {
       super.viewDidLoad()
       view.addSubview(player)
       player.loadVideoID(video_link)

       player.snp.makeConstraints { make in
           make.edges.equalToSuperview()
       }
   }

}
