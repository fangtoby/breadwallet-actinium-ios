//
//  WalletCreationTests.swift
//  graviumwallet
//
//  Created by Adrian Corscadden on 2017-02-26.
//  Copyright © 2018 Graviumwallet Team. All rights reserved.
//

import XCTest
@testable import breadwallet

class WalletCreationTests: XCTestCase {

    private let walletManager: WalletManager = try! WalletManager(currency: Currencies.rvn, dbPath: nil)

    override func setUp() {
        super.setUp()
        clearKeychain()
    }

    override func tearDown() {
        super.tearDown()
        clearKeychain()
    }

    func testWalletCreation() {
        XCTAssertNotNil(walletManager.setRandomSeedPhrase(), "Seed phrase should not be nil.")
    }
}
