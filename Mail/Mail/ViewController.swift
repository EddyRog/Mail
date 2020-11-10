//
//  ViewController.swift
//  Mail
//
//  Created by Eddy R on 09/11/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import UIKit

struct Mail {
    var title: String?
    var detail: [String]?
    
    init(title: String, detail: [String]) {
        self.title = title
        self.detail = detail
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var defaultFirstHeaderRow: CGFloat = 60
    var defaultRestOfHeaderRow: CGFloat = 30

    var mailArray = [Mail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        spinnerLoadingTableView() // set data
        setArrayMail() // set data
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mailArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailArray[section].detail?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = mailArray[indexPath.section].detail?[indexPath.row]
        return cell
    }
}

extension ViewController {
    // Spinner reload
    func spinnerLoadingTableView() {
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        tableView?.alwaysBounceVertical = true
        tableView?.addSubview(refreshControl)
        
        // custom on refresh mail
        let myString = NSMutableAttributedString(string: "Fetching Data")
        myString.addAttribute(.foregroundColor, value: UIColor.red, range: NSMakeRange(0, 5))
        refreshControl.attributedTitle = myString
        tableView?.addSubview(refreshControl)
    }
    @objc func pullToRefresh(sender: UIRefreshControl) {
        DispatchQueue.global(qos: .background).async {
            sleep(UInt32(2))
            DispatchQueue.main.sync {
                sender.endRefreshing()
                print("refresh")
            }
        }
    }
}

// header // footer
extension ViewController {
    
    // header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return defaultRestOfHeaderRow
        } else {
            return defaultFirstHeaderRow
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .black
        
        if section != 0 {
            // Label BLACK
            let label = UILabel()
            label.frame = CGRect(x: 10, y:0, width: tableView.frame.size.width, height: defaultRestOfHeaderRow)
            label.text = mailArray[section].title
            label.textColor = .gray
            label.backgroundColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 14)
            
            v.addSubview(label)
            
            return v
        } else {
            // Label BLACK
            let label = UILabel()
            label.frame = CGRect(x: 20, y:0, width: tableView.frame.size.width, height: defaultFirstHeaderRow)
            label.text = mailArray[section].title
            label.textColor = .gray
            //            label.backgroundColor = .yellow
            label.backgroundColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 40)
            label.textColor = UIColor.white
            //            label.numberOfLines = 2
            label.minimumScaleFactor = 0.2
            label.adjustsFontSizeToFitWidth = true
            
            v.addSubview(label)
            
            return v
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mailArray[section].title
    }
    
    // footer tableview
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }
}

extension ViewController {
    // Set Mail
    func setArrayMail() {
        mailArray.append(Mail(title: "Boîtes", detail:["-Toutes les boites","-iCloud","-Gmail","-Yahoo","-VIP", "-Special"]))
        mailArray.append(Mail(title: "ACTION MAIL", detail:["Reception","Brouillon","envoyé","Corbeille","Archive"]))
        mailArray.append(Mail(title: "ACTION MAIL", detail:["Reception","Brouillon","envoyé","Corbeille","Archive"]))
    }
}
