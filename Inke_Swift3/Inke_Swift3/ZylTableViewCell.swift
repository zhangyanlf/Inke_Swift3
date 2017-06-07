//
//  ZylTableViewCell.swift
//  Inke_Swift3
//
//  Created by 张彦林 on 17/6/6.
//  Copyright © 2017年 zhangyanlf. All rights reserved.
//

import UIKit

class ZylTableViewCell: UITableViewCell {
    /*
     *portraitImg 主播头像
     *portraitBigImg 主播大图
     *nikeLabel 主播昵称
     *location  主播位置
     *viewersLabel  当前观看人数
     */
    @IBOutlet weak var portraitImg: UIImageView!
    
    @IBOutlet weak var portraitBigImg: UIImageView!
    
    @IBOutlet weak var nikeLabel: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var viewersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
