//
//  ModalNavigationController.swift
//  graviumwallet
//
//  Created by Adrian Corscadden on 2016-11-23.
//  Copyright © 2018 Graviumwallet Team. All rights reserved.
//

import UIKit

class ModalNavigationController : UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let vc = topViewController else { return .default }
        return vc.preferredStatusBarStyle
    }
}
