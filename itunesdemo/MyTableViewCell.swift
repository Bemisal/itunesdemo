//
//  MyTableViewCell.swift
//  itunesdemo
//
//  Created by Yousaf on 11/04/2019.
//  Copyright © 2019 Codenterprise. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    lazy var backview:UIView = {
        let view  = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width-20, height: 110))
      //  let view  = UIView(frame: CGRect(x: 10, y: 6, width: 375-20, height: 667))
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
        return namelbl
    }()
    
    lazy var mediatypelbl : UILabel = {
        let mediatypelbl = UILabel (frame: CGRect(x: 116, y: 42, width: backview.frame.width - 116, height: 30))
        mediatypelbl.textAlignment = .left
        mediatypelbl.font = UIFont.boldSystemFont(ofSize: 18)
        return mediatypelbl
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
        backview.addSubview(mediatypelbl)
    }
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backview.layer.cornerRadius = 5
        backview.clipsToBounds = true
    }

}
