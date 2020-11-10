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

extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors
        
        UIGraphicsBeginImageContext(gradient.bounds.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
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
    // SETTING | NAVIGATION ITEM / TITLE
    let navBarAppearance = UINavigationBarAppearance()
    var topItemLabel = UILabel()
    
    
    // MARK: - CYCLE LIFE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        spinnerLoadingTableView() // set data
        
        //setup
        setDataArrayMail()
        setUpNavigationItem()
        setUpNavigationItemForTopItem()
        setUpViewToBlackColor()
        customNavBarTransparency() // custom image for navbar transparency
    }
    
    func customNavBarTransparency() {
        //*****************
        guard let bounds = navigationController?.navigationBar.bounds else { return }
        
        var backImageForDefaultBarMetrics = UIImage.gradientImage(bounds: bounds, colors: [UIColor.black.cgColor, UIColor.systemFill.cgColor])
        backImageForDefaultBarMetrics = backImageForDefaultBarMetrics.resizableImage( withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: backImageForDefaultBarMetrics.size.height - 1, right: backImageForDefaultBarMetrics.size.width - 1))
        
        let navigationBarAppearance = self.navigationController!.navigationBar
        navigationBarAppearance.setBackgroundImage(backImageForDefaultBarMetrics, for: .default)
        //*****************
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    // MARK: - SETTING | NAVIGATION ITEM
    fileprivate func setUpViewToBlackColor() {
        self.view.backgroundColor = UIColor.black
        self.tableView.backgroundColor = UIColor.black // view and tableView on top
    }
    fileprivate func setUpNavigationItem() {
        // set data
//        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        //MARK: -
        // FIXME: remettre sur clear par default
//        navBarAppearance.backgroundColor = UIColor.clear
        navBarAppearance.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5)
        // MARK: -
        
        self.navigationItem.standardAppearance = navBarAppearance
        self.navigationItem.compactAppearance = navBarAppearance
        self.navigationItem.scrollEdgeAppearance = navBarAppearance
        
        // test test test
    }
    fileprivate func setUpNavigationItemForTopItem() {
        // label For Top item ( title )
        topItemLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        topItemLabel.text = mailArray[0].title
        //        lab.backgroundColor = .red
        topItemLabel.textColor = UIColor.white
        topItemLabel.alpha = 0
        self.navigationItem.titleView = topItemLabel
    }
    
    var debugT:Bool? = nil
    var mess:String = ""
}

// MARK: - SCROLLING TABLEVIEW
extension ViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 📢 : defaultFirstHeaderRow 60 px.
        let verticalOffset = scrollView.contentOffset.y
        let scrollAmount = verticalOffset - lastVerticalOffset // get amount scrolling since last time
        lastVerticalOffset = verticalOffset // set the last offset each time scrolling
        
        let alphaVariation = scrollAmount/(defaultFirstHeaderRow)
        
        print("debug\(mess) : \(debugT) | vOffset : \(verticalOffset) | scrollAmount : \(scrollAmount) | lastVerticalOffset : \(lastVerticalOffset) | alpahVariation : \(alphaVariation) ")
        
        switch verticalOffset {
            case _ where verticalOffset < defaultFirstHeaderRow:
                mess = "verticalOffset < defaultFirstHeaderRow"
                debugT = verticalOffset < defaultFirstHeaderRow
                topItemLabel.alpha = 0 // show label after 60px under
            // cacher label dans navigation bar en animation
            
            case _ where verticalOffset >= defaultFirstHeaderRow:
                // afficher boite dans navigation Bar
                mess = "verticalOffset >= defaultFirstHeaderRow"
                debugT = verticalOffset >= defaultFirstHeaderRow
                topItemLabel.alpha = 1 // show label after 60px down
                
        
            
            default:
            break
        }
        
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
    func setDataArrayMail() {
        mailArray.append(Mail(title: "Boîtes", detail:["-Toutes les boites","-iCloud","-Gmail","-Yahoo","-VIP", "-Special"]))
        mailArray.append(Mail(title: "ACTION MAIL", detail:["Reception","Brouillon","envoyé","Corbeille","Archive"]))
        mailArray.append(Mail(title: "ACTION MAIL", detail:["Reception","Brouillon","envoyé","Corbeille","Archive", "magie", "Draft", "mario"]))
    }
}




