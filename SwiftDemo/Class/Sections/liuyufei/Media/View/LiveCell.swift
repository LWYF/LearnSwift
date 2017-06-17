//
//  LiveCell.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/15.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class LiveCell: UITableViewCell {

    var headerImage: UIImageView!
    var liveName: UILabel!
    var liveAddress: UILabel!
    var livingPicture: UIImageView!
    var livingStatus: UILabel!
    
    
    fileprivate let headerImage_height: CGFloat = 40
    fileprivate let label_height: CGFloat = 20
    fileprivate let label_width: CGFloat = 100
    
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
        /*iOS10后这样设置不会造成卡顿现象
        iOS10之前要自己剪切
         */
        headerImage.layer.masksToBounds = true
        headerImage.layer.cornerRadius = headerImage_height / 2
        self.contentView.addSubview(headerImage)
        
        headerImage.snp.makeConstraints { (make) in
            make.left.top.equalTo(MARGIN)
            make.width.height.equalTo(headerImage_height)
        }
        
        liveName = UILabel.init()
        self.contentView.addSubview(liveName)
        
        liveName.snp.makeConstraints { (make) in
            make.left.equalTo(headerImage.snp.right).offset(MARGIN)
            make.top.equalTo(headerImage.snp.top)
            make.right.equalTo(-label_width)
            make.height.equalTo(label_height)
        }

        liveAddress = UILabel.init()
        self.contentView.addSubview(liveAddress)
        
        liveAddress.snp.makeConstraints { (make) in
            make.left.right.equalTo(liveName)
            make.top.equalTo(liveName.snp.bottom)
            make.height.equalTo(label_height)
        }
       
        livingPicture = UIImageView.init()
        self.contentView.addSubview(livingPicture)
        
        livingPicture.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(headerImage.snp.bottom)
        }
    }
    
    var livingContent: livesModel? {
        didSet {
            //头像
            if let strURL = livingContent?.creater.portrait {
                headerImage.kf.setImage(with: URL(string: strURL))
                livingPicture.kf.setImage(with: URL(string: strURL))
            }
            //直播名称
            if let strName = livingContent?.creater.nick {
                liveName.text = strName
            }
            //直播地址
            if let strAddress = livingContent?.city {
                liveAddress.text = strAddress
            }
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
