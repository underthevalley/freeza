//
//  SettingsTableViewController.swift
//  freeza
//
//  Created by Nat Sibaja on 12/29/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import UIKit

enum Settings {
    case safeMode
}
class SettingsTableViewController: UITableViewController {

    let tableFooterView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
    private func configureViews() {
        
        func configureTableView() {
            self.tableFooterView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 80)
            self.tableView.tableFooterView = self.tableFooterView
        }
        
        configureTableView()
    }
}

extension SettingsTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toggleSettingCell = tableView.dequeueReusableCell(withIdentifier: ToggleSettingTableViewCell.cellId, for: indexPath as IndexPath) as! ToggleSettingTableViewCell
        return toggleSettingCell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
}
