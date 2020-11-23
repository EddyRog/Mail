//
//  StaticTableViewController.swift
//  Mail
//
//  Created by Eddy R on 15/11/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import UIKit

struct Account {
    var isExpanded: Bool
    var name: String
    var folders: Array<String>
    
}

class MainTableViewController: UITableViewController {
    @IBOutlet var tableViewS: UITableView!
    
    var accountsMail = [
        Account(isExpanded: true, name: "iCloud", folders: ["reception","reception","reception",]), // 1 --> 2
        Account(isExpanded: true, name: "Gmail", folders: ["reception","brouillon"]), // 2 --> 3
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "WiFiCell", bundle: nil), forCellReuseIdentifier: "WiFiCell")
        
        self.title = "Boîtes"
        self.navigationController?.navigationBar.tintColor = .black
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return accountsMail.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if accountsMail[section].isExpanded {
            return accountsMail[section].folders.count
        } else {
            return 0
        }
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let folder = accountsMail[indexPath.section].folders[indexPath.row]
        cell.textLabel?.text = folder
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    @objc func tapped(sender: UITapGestureRecognizer){
//        print(sender.view?.subviews[0].tag)
        
        // targeting SubViews
        //let label = sender.view?.subviews[0] as? UILabel ?? UILabel()
        let icon = sender.view?.subviews[1] as? UIImageView ?? UIImageView()
        
        // get current tag to handling right row
        let section = sender.view?.tag ?? 0
        var indexPaths = [IndexPath]()
        
        // count n row in section
        for row in accountsMail[section].folders.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        // toggle
        let isExpanded = accountsMail[section].isExpanded
        accountsMail[section].isExpanded = !isExpanded
        
        //Animation icone
        if isExpanded {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
                icon.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            })
        } else {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
                icon.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            })
        }
        
        // manage row in tableView
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // general container
        let viewRow = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 36))
        viewRow.backgroundColor = .cyan
        viewRow.tag = section // give the right tag
        
        // add gesture whole view containing 2 views
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)) )
        viewRow.addGestureRecognizer(tap)

        // label
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - (15+36), height: 36))
        label.backgroundColor = .orange
        label.text = "test"
        label.tag = section
        
        // icon chevron
        let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        icon.image = UIImage(systemName: "chevron.down")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .gray
        
        // adding in the main view
        viewRow.addSubview(label)
        viewRow.addSubview(icon)
        
        // setup constraints
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        viewRow.addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: viewRow, attribute: .leading, multiplier: 1, constant: 30))
        viewRow.addConstraint(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: icon, attribute: .leading, multiplier: 1, constant: 0))
        viewRow.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: viewRow, attribute: .top, multiplier: 1, constant: 0))
        viewRow.addConstraint(NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: viewRow, attribute: .bottom, multiplier: 1, constant: 0))
        
        // icon
        icon.translatesAutoresizingMaskIntoConstraints = false
        viewRow.addConstraint(NSLayoutConstraint(item: icon, attribute: .leading, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: 0))
        viewRow.addConstraint(NSLayoutConstraint(item: icon, attribute: .trailing, relatedBy: .equal, toItem: viewRow, attribute: .trailing, multiplier: 1, constant: -15))
        viewRow.addConstraint(NSLayoutConstraint(item: icon, attribute: .top, relatedBy: .equal, toItem: viewRow, attribute: .top, multiplier: 1, constant: 0))
        viewRow.addConstraint(NSLayoutConstraint(item: icon, attribute: .bottom, relatedBy: .equal, toItem: viewRow, attribute: .bottom, multiplier: 1, constant: 0))
        icon.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
        return viewRow
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
