//
//  ToggleSettingTableViewCell.swift
//  freeza
//
//  Created by Nat Sibaja on 12/29/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import UIKit

/// This class should be refactored to load settings items based on a struct of settings in the tableVC and parameters for labels
class ToggleSettingTableViewCell: UITableViewCell {
    static let cellId = "ToggleSettingTableViewCell"

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var settingSwitch: UISwitch!
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.configureViews()
    }
    @IBAction func toggleSwitch(_ sender: AnyObject) {
        AppData.enableSafeMode.toggle()
    }
    private func configureViews() {
        
        func configureSwitch() {
            self.settingSwitch.setOn(AppData.enableSafeMode, animated: true)
        }
        configureSwitch()
    }
}
