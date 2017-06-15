//
//  LiveCell.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/15.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import SnapKit

class LiveCell: UITableViewCell {

    var headerImage: UIImageView!
    var liveName: UILabel!
    var liveAddress: UILabel!
    var watchedNum: UILabel!
    var livingPicture: UIImageView!
    var livingStatus: UILabel!
    
    
    fileprivate let headerImage_height: CGFloat = 40
    fileprivate let watchedNum_width: CGFloat = 100
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadView()
    }
    
    private func loadView() {
        headerImage = UIImageView.init()
        self.contentView.addSubview(headerImage)
        
        headerImage.snp.makeConstraints { (make) in
            make.left.top.equalTo(MARGIN)
            make.width.height.equalTo(headerImage_height)
        }
        
        liveName = UILabel.init()
        self.contentView.addSubview(liveName)
        
        liveName.snp.makeConstraints { (make) in
            make.left.equalTo(headerImage.snp.right).offset(MARGIN)
            make.top.equalTo(headerImage).offset(0)
        }
        
        liveAddress = UILabel.init()
        self.contentView.addSubview(liveAddress)
        
        liveAddress.snp.makeConstraints { (make) in
            make.left.equalTo(liveName).offset(0)
            make.top.equalTo(liveName).offset(0)
        }
        
        watchedNum = UILabel.init()
        watchedNum.textAlignment = .right
        self.contentView.addSubview(watchedNum)
        
        watchedNum.snp.makeConstraints { (make) in
            make.right.equalTo(MARGIN)
            make.width.equalTo(watchedNum_width)
            make.centerX.equalTo(self)
        }
        
        livingPicture = UIImageView.init()
        self.contentView.addSubview(livingPicture)
        
        livingPicture.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(headerImage).offset(MARGIN)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
