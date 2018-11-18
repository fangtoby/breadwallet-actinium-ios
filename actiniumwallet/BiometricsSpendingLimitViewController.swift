//
//  BiometricsSpendingLimitViewController.swift
//  actiniumwallet
//
//  Created by Adrian Corscadden on 2017-03-28.
//  Copyright © 2018 Actiniumwallet Team. All rights reserved.
//

import UIKit
import LocalAuthentication
import BRCore

class BiometricsSpendingLimitViewController: UITableViewController, Subscriber {

    private let cellIdentifier = "CellIdentifier"
    private let walletManager: WalletManager
    private let limits: [UInt64] = [0, 100000000*50, 100000000*500, 100000000*1000, 100000000*5000, 100000000*10000]
    private var selectedLimit: UInt64?
    private var header: UIView?
    private let amount = UILabel(font: .customMedium(size: 26.0), color: .darkText)
    private let body = UILabel.wrapping(font: .customBody(size: 13.0), color: .darkText)
    
    init(walletManager: WalletManager) {
        self.walletManager = walletManager
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        if limits.contains(walletManager.spendingLimit) {
            selectedLimit = walletManager.spendingLimit
        }
        tableView.register(SeparatorCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50.0
        tableView.backgroundColor = .whiteTint
        tableView.separatorStyle = .none

        let titleLabel = UILabel(font: .customBold(size: 17.0), color: .darkText)
        let biometricsTitle = LAContext.biometricType() == .face ? S.FaceIdSpendingLimit.title : S.TouchIdSpendingLimit.title
        titleLabel.text = biometricsTitle
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel

        let faqButton = UIButton.buildFaqButton(articleId: ArticleIds.touchIdSpendingLimit)
        faqButton.tintColor = .darkText
        navigationItem.rightBarButtonItems = [UIBarButtonItem.negativePadding, UIBarButtonItem(customView: faqButton)]

        body.text = S.TouchIdSpendingLimit.body

        //If the user has a limit that is not a current option, we display their limit
        if !limits.contains(walletManager.spendingLimit) {
            if let rate = Currencies.rvn.state.currentRate {
                let spendingLimit = Amount(amount: walletManager.spendingLimit, rate: rate, maxDigits: Currencies.rvn.state.maxDigits, currency: Currencies.rvn)
                setAmount(limitAmount: spendingLimit)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return limits.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let limit = limits[indexPath.row]
        if limit == 0 {
            cell.textLabel?.text = S.TouchIdSpendingLimit.requirePasscode
        } else {
            let displayAmount = DisplayAmount(amount: Satoshis(rawValue: limit), selectedRate: nil, minimumFractionDigits: 0, currency: Currencies.rvn)
            cell.textLabel?.text = displayAmount.combinedDescription
        }
        
        if limits[indexPath.row] == selectedLimit {
            let check = UIImageView(image: #imageLiteral(resourceName: "CircleCheck").withRenderingMode(.alwaysTemplate))
            check.tintColor = C.defaultTintColor
            cell.accessoryView = check
        } else {
            cell.accessoryView = nil
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newLimit = limits[indexPath.row]
        selectedLimit = newLimit
        walletManager.spendingLimit = newLimit
        amount.isHidden = true
        amount.constrain([
            amount.heightAnchor.constraint(equalToConstant: 0.0) ])
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = self.header { return header }
        let header = UIView(color: .whiteTint)
        header.addSubview(amount)
        header.addSubview(body)
        amount.pinTopLeft(padding: C.padding[2])
        body.constrain([
            body.leadingAnchor.constraint(equalTo: amount.leadingAnchor),
            body.topAnchor.constraint(equalTo: amount.bottomAnchor),
            body.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -C.padding[2]),
            body.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -C.padding[2]) ])
        self.header = header
        return header
    }

    private func setAmount(limitAmount: Amount) {
        amount.text = "\(limitAmount.bits) = \(limitAmount.localCurrency)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}