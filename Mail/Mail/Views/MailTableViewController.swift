//
//  MailTableViewController.swift
//  Mail
//
//  Created by Eddy R on 15/11/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import UIKit


class DataSource: NSObject {
    
}

class MailTableViewController: UITableViewController {
    
    var mail :[[Any]] =
        [// mail
            ["icloud", ["reception", "draft"]], // 0 array
            ["gmail", ["reception", "draft","jeter"] ] //1 array
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Boîtes"
        self.navigationController?.navigationBar.tintColor = .black
        
        dump((mail[0][1] as? Array<String>)?.count)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mail.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (mail[section][1] as? Array<String>)?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let accountMail = mail[indexPath.section][1] as! Array<String>
        cell.textLabel?.text = accountMail[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let accountString = mail[section][0] as? String
        return accountString
    }

}

class BoxMail: UITableViewController {
    
}
