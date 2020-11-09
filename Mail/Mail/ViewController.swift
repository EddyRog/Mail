//
//  ViewController.swift
//  Mail
//
//  Created by Eddy R on 09/11/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        spinnerLoadingTableView()
    }
    
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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "test"
        return cell
    }
}

