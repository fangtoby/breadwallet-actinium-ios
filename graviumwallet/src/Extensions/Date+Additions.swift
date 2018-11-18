//
//  Date+Additions.swift
//  graviumwallet
//
//  Created by Adrian Corscadden on 2017-06-09.
//  Copyright © 2018 Graviumwallet Team. All rights reserved.
//

import Foundation

extension Date {
    func hasEqualYear(_ date: Date) -> Bool {
        return Calendar.current.compare(self, to: date, toGranularity: .year) == .orderedSame
    }

    func hasEqualMonth(_ date: Date) -> Bool {
        return Calendar.current.compare(self, to: date, toGranularity: .month) == .orderedSame
    }
}
