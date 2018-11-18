//
//  UITableView+Additions.swift
//  actiniumwallet
//
//  Created by Adrian Corscadden on 2017-01-08.
//  Copyright © 2018 Actiniumwallet Team. All rights reserved.
//

import UIKit

extension UITableView {
    func reload(row: Int, section: Int) {
        beginUpdates()
        reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        endUpdates()
    }
}
