//
//  SeparatorCell.swift
//  graviumwallet
//
//  Created by Adrian Corscadden on 2017-04-01.
//  Copyright © 2018 Graviumwallet Team. All rights reserved.
//

import UIKit

class SeparatorCell : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let separator = UIView()
        separator.backgroundColor = .separator
        addSubview(separator)
        separator.constrain([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.0) ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
