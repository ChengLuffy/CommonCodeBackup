//
//  AutoHeightCell.swift
//  AutoLayoutTest
//
//  Created by 成殿 on 2/1/2019.
//  Copyright © 2019 成殿. All rights reserved.
//

import UIKit

class AutoHeightCell: UITableViewCell {

    
    lazy var avatar: UIImageView = {
        let avatar = UIImageView(frame: .zero)
        return avatar
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        label.text = "text"
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configSubviews() {
        contentView.addSubview(avatar)
        avatar.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(40)
            maker.top.left.equalTo(self.contentView).offset(15)
        }
        
        contentView.addSubview(titleLabel)
        let float = UIScreen.main.bounds.size.width - 40 - 15 - 15 - 15
        titleLabel.preferredMaxLayoutWidth = float
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.avatar.snp_rightMargin).offset(15)
            maker.right.equalTo(self.contentView).offset(-15)
            maker.top.equalTo(self.avatar)
            maker.bottom.equalTo(self.contentView).offset(-15)
        }
        
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
    }

}
