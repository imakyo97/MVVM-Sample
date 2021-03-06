//
//  TimeLineCell.swift
//  GitHubClientApp
//
//  Created by 今村京平 on 2021/07/06.
//

import UIKit

final class TimeLineCell: UITableViewCell {

    /*
     ユーザーのiconを表示させるためのUIImageView
     */
    private var iconView: UIImageView!

    /*
     ユーザーのnickNameを表示させるためのUILabel
     */
    private var nickNameLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        iconView = UIImageView()
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)

        nickNameLabel = UILabel()
        nickNameLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(nickNameLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.frame = CGRect(x: 15,
                                y: 15,
                                width: 45,
                                height: 45)
        iconView.layer.cornerRadius = iconView.frame.size.width / 2

        nickNameLabel.frame = CGRect(x: iconView.frame.maxX + 15,
                                     y: iconView.frame.origin.y,
                                     width: contentView.frame.width
                                        - iconView.frame.maxX - 15 * 2,
                                     height: 15)
    }

    /*
     ユーザーのnickNameをセット
     */
    func setNickName(nickName: String) {
        nickNameLabel.text = nickName
    }

    /*
     ユーザーのiconをセット
     */
    func setIcon(icon: UIImage) {
        iconView.image = icon
    }
}
