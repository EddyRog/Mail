//
//  ViewController.swift
//  Mail
//
//  Created by Eddy R on 09/11/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

// ❔ Quoi   - 🗺 Ou   - ⏳Quand - ✋Comment
// 🤸🏽 Action - 🗺 Lieu - ⏳Temps - ✋Maniere

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

    // MARK: - iVAR - CONSTANT - IB
    // TABLEVIEW FROM SB
    @IBOutlet weak var tableView: UITableView!
    // SPINNER RELOAD DATA
    var refreshControl = UIRefreshControl()
    // HEIGHT ROW : HEADER | FOOTER
    var defaultFirstHeaderRow: CGFloat = 60
    var defaultRestOfHeaderRow: CGFloat = 30
    // DATA HYDRATE TABLEVIEW
    var mailArray = [Mail]()
    @IBOutlet weak var navigationItemcustom: UINavigationItem!
    // SCROLLING TABLEVIEW
    var lastVerticalOffset: CGFloat = 0
    var headerViewOriginalHeight: CGFloat = 0
    
    
    // MARK: - CYCLE LIFE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light // force dark theme on ios
        spinnerLoadingTableView() // set data
        
        //setup
        setArrayMail()
        setUpNavigationItem()
        setUpView()
    }
    
    // MARK: - SETTING
    fileprivate func setUpNavigationItem() {
        // set data
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.black
        
        self.navigationItem.standardAppearance = navBarAppearance
        self.navigationItem.compactAppearance = navBarAppearance
        self.navigationItem.scrollEdgeAppearance = navBarAppearance
    }
    fileprivate func setUpView() {
        self.view.backgroundColor = UIColor.black
        self.tableView.backgroundColor = UIColor.black // view and tableView on top
    }
    
}

// MARK: - SCROLLING TABLEVIEW
extension ViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 📢 : defaultFirstHeaderRow 60 px.
        let verticalOffset = scrollView.contentOffset.y
        let scrollAmount = verticalOffset - lastVerticalOffset // get amount scrolling since last time
        lastVerticalOffset = verticalOffset // set the last offset each time scrolling
        
        let alphaVariation = scrollAmount/(defaultFirstHeaderRow)
        
        print("vOffset : \(verticalOffset) | scrollAmount : \(scrollAmount) | lastVerticalOffset : \(lastVerticalOffset) | alpahVariation : \(alphaVariation) ")
        
        
        //        switch newConstant {
        //            case _ where newConstant >= 0:
        //                newConstant = 1
        ////                lab.alpha = 0
        //
        //            case _ where newConstant <= -defaultFirstHeaderRow/2:
        //                // -62 -61 -60  <- [0] -> 1 2 3
        //                newConstant = 0
        ////                lab.alpha += alphaVariation
        //
        //            case _ where newConstant > -defaultFirstHeaderRow/2:
        //                newConstant = defaultFirstHeaderRow
        ////                lab.alpha = 0
        //            default:
        //                break
        //        }
    }
}

// MARK: - DATASOURCE - TABLEVIEWDELEGATE
extension ViewController: UITableViewDataSource, UITableViewDelegate {
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

// MARK: - SPINNER RELOAD DATA
extension ViewController {
    // Spinner reload
    func spinnerLoadingTableView() {
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        tableView?.alwaysBounceVertical = true
        tableView?.addSubview(refreshControl)
        
        // custom on refresh mail
        let myString = NSMutableAttributedString(string: "Fetching Data")
        myString.addAttribute(.foregroundColor, value: UIColor.orange, range: NSRange(location: 0, length: myString.length))
        myString.addAttribute(.foregroundColor, value: UIColor.white, range: NSMakeRange(0, 5))
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

// MARK: - HEIGHT ROW : HEADER | FOOTER
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
        v.backgroundColor = .clear
        
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
            
            //MARK: -
            // FIXME: a remettre en clear
//            label.backgroundColor = .clear
            label.backgroundColor = .orange
            // MARK: -
            label.font = UIFont.boldSystemFont(ofSize: 40)
            label.textColor = UIColor.white
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
        
        v.backgroundColor = .red
        return v
    }
}

// MARK: - DATA HYDRATE TABLEVIEW
extension ViewController {
    // Set Mail
    func setArrayMail() {
        mailArray.append(Mail(title: "Boîtes", detail:["-Toutes les boites","-iCloud","-Gmail","-Yahoo","-VIP", "-Special"]))
        mailArray.append(Mail(title: "ACTION MAIL", detail:["Reception","Brouillon","envoyé","Corbeille","Archive"]))
        mailArray.append(Mail(title: "ACTION MAIL", detail:["Reception","Brouillon","envoyé","Corbeille","Archive"]))
    }
}




