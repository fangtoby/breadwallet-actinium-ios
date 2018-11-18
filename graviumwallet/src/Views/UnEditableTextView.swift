//
//  UnEditableTextView.swift
//  graviumwallet
//
//  Created by Adrian Corscadden on 2017-04-04.
//  Copyright © 2018 Graviumwallet Team. All rights reserved.
//

import UIKit

class UnEditableTextView : UITextView {
    override var canBecomeFirstResponder: Bool {
        return false
    }
}
