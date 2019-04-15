//
//  MyTableViewCell.swift
//  itunesdemo
//
//  Created by Bemisal on 11/04/2019.
//  Copyright © 2019 Codenterprise. All rights reserved.
//

import UIKit
import MediaPlayer
import StoreKit


class MyTableViewCell: UITableViewCell {

    var myMusicPlayer = MPMusicPlayerController.applicationMusicPlayer
    var userlibrary = MPMediaLibrary.init()
    let serviceController = SKCloudServiceController()
    //variable get get id for song
    var strid : String = String ()
   
    
    lazy var backview:UIView = {
        let view  = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width-20, height: 110))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var myimage : UIImageView = {
        let image = UIImageView (frame: CGRect(x: 4, y: 4, width: 104, height: 104))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 52
        image.clipsToBounds = true
        return image
    }()
    
    lazy var namelbl : UILabel = {
        let namelbl = UILabel (frame: CGRect(x: 116, y: 8, width: backview.frame.width - 116, height: 30))
        namelbl.textAlignment = .left
        namelbl.font = UIFont.boldSystemFont(ofSize: 18)
        namelbl.numberOfLines=2
        return namelbl
    }()
    
    lazy var playbutton : UIButton = {
        let playbutton = UIButton (frame: CGRect(x: 116, y: 52, width: backview.frame.width - 216, height: 30))
        playbutton.setTitle("PLAY", for: .normal)
        playbutton.setTitleColor(UIColor.white, for: .normal)
        playbutton.backgroundColor = UIColor.red
        playbutton.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
        return playbutton
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        addSubview(backview)
        backview.addSubview(myimage)
        backview.addSubview(namelbl)
        backview.addSubview(playbutton)
    }
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.brown
        backview.layer.cornerRadius = 5
        backview.clipsToBounds = true
    }
    @objc func pressed(sender: UIButton!) {
         DispatchQueue(label: "parsing", qos: .userInitiated).async {
        //SKCloudServiceController API to determine the current capabilities
            self.serviceController.requestCapabilities { (capability:SKCloudServiceCapability, err:Error?) in
            guard err == nil else {
                print("error in capability check is \(err!)")
                return
            }
            if capability.contains(SKCloudServiceCapability.musicCatalogPlayback) {
                print("user has Apple Music subscription and can play music from apple music api")
            }
            
            if capability.contains(SKCloudServiceCapability.addToCloudMusicLibrary) {
                print("user has an Apple Music subscription, can play music from api, also can add to their music library")
            }
            
            if #available(iOS 10.1, *) {
                if capability.contains(SKCloudServiceCapability.musicCatalogSubscriptionEligible) {
                    print("user does not have subscription")
                }
            } else {
                // Fallback on earlier versions
            }
        }
        //adding a track to the library
            self.userlibrary.addItem(withProductID: self.strid) { (entity, error) in
            if let error = error {
                NSLog("Error: \(error.localizedDescription)")
            }
        }
        //playing a track
            self.myMusicPlayer.setQueue(with: [self.strid])
            self.myMusicPlayer.prepareToPlay()
            self.myMusicPlayer.play()
            DispatchQueue.main.async {
                
            }
            }
    }
}
