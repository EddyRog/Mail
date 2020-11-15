//
//  ViewController.swift
//  Mail
//
//  Created by Eddy R on 09/11/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//


import UIKit
// MARK: - Model
struct Mail {
    var title: String?
    var detail: [[String:String]]?
    var isOpened: Bool?
    
    init(title: String, detail: [[String:String]], ispOpened: Bool) {
        self.title = title
        self.detail = detail
        self.isOpened = ispOpened
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var mailArray: [Mail] = [] // MODEL
    var defaultFirstHeaderRow: CGFloat = 1 // HEIGHT ROW : HEADER
    var defaultRestOfHeaderRow: CGFloat = 30
    
    // ⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬
    
    let mv = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    // MARK: - CYCLE LIFE
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataArrayForMail()
        self.title = mailArray[0].title // set title off navigation Bar
        setUpRefreshControl()
        
        mv.backgroundColor = .red
    }
    
    @objc func didpull() {
        print("didpull")
        DispatchQueue.global(qos: .background).async {
            sleep(UInt32(2))
            DispatchQueue.main.sync {
                self.tableView.refreshControl?.endRefreshing()
                print("refresh")
            }
        }
    }
    
    // MARK: - SET UP
    //model
    func setDataArrayForMail() {
        /*
         Mail["title":"...", "details": [
            [
                "icon":"forward",
                "title":"Toutes les boites",
                "count":"12"
                "iconForward":"forward"
            ],
             [
             "icon":"forward",
             "title":"Toutes les boites",
             "count":"12"
             "iconForward":"forward"
             ],
         ]]
         */
        
        mailArray.append(Mail(title: "Boîtes", detail:
                                [
                                    ["icon":"tray.2","title":"Toutes les boites mails", "count":"1" ],
                                    ["icon":"tray","title":"Icloud", "count":"5" ],
                                    ["icon":"tray","title":"Gmail", "count":"4842" ],
                                    ["icon":"star", "title":"VIP", "count":"_" ]
                                ], ispOpened: true
        ))
        mailArray.append(Mail(
            title: "Boîtes",
            detail:
                [
                    ["icon":"tray.2","title":"Toutes les boites mails", "count":"1" ],
                    ["icon":"tray","title":"Icloud", "count":"5" ],
                    ["icon":"tray","title":"Gmail", "count":"4842" ],
                    ["icon":"star", "title":"VIP", "count":"_" ]
                ], ispOpened: true
        ))
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mailArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailArray[section].detail?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MailTableViewCell
        
        // ✔︎ ICONMAIN
        cell.iconMain.image = UIImage(systemName: mailArray[indexPath.section].detail?[indexPath.row]["icon"] ?? "")
        // ✔︎ TITLE
        cell.title.text = mailArray[indexPath.section].detail?[indexPath.row]["title"] ?? ""
        
        // ❔ Quoi   - 🗺 Ou   - ⏳Quand - ✋Comment
        // 🤸🏽 Action - 🗺 Lieu - ⏳Temps - ✋Maniere
        
        // ✔︎ COUNT
        let count = mailArray[indexPath.section].detail?[indexPath.row]["count"] ?? ""
        if count == "_" {
            // images
            let lVipImage = UIImageView(image: UIImage(systemName: "info.circle"))
            lVipImage.frame = cell.customViewRow.bounds
            lVipImage.contentMode = UIView.ContentMode.right
            cell.customViewRow.backgroundColor = .clear
            cell.customViewRow.addSubview(lVipImage)
        } else {
            // label // ✔︎
            let lLabelCount = UILabel(frame: cell.customViewRow.bounds)
            lLabelCount.textAlignment = .right
            lLabelCount.text = count
            cell.customViewRow.backgroundColor = .clear
            cell.customViewRow.addSubview(lLabelCount)
        }
        
//        cell.details.text = mailArray[indexPath.section].detail?[indexPath.row]
//        cell.textLabel?.text = mailArray[indexPath.section].detail?[indexPath.row]
//        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}


// MARK: - HEADER TABLEVIEW
extension ViewController {
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
            label.frame = CGRect(x: 0, y:0, width: tableView.frame.size.width, height: defaultFirstHeaderRow)
            label.text = ""
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
}

// MARK: - FOOTER TABLEVIEW
extension ViewController {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }
}

// MARK: - SPINNER RELOAD DATA
extension ViewController {
    // Spinner behind TableView
    func setUpRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        // custom on refresh mail
        let myString = NSMutableAttributedString(string: "Fetching Data")
        myString.addAttribute(.foregroundColor, value: UIColor.orange, range: NSRange(location: 0, length: myString.length))
        myString.addAttribute(.foregroundColor, value: UIColor.purple, range: NSMakeRange(0, 5))
        tableView.refreshControl?.attributedTitle = myString
        tableView.refreshControl?.tintColor = .red
        tableView.refreshControl?.addTarget(self, action: #selector(didpull), for: .valueChanged)
    }
//
}





































/*
 
 
 
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
 gradient.colors = colorsoverride func viewDidLoad() {
 super.viewDidLoad()
 
 UIGraphicsBeginImageContext(gradient.bounds.size)
 gradient.render(in: UIGraphicsGetCurrentContext()!)
 let image = UIGraphicsGetImageFromCurrentImageContext()
 UIGraphicsEndImageContext()
 
 return image!
 }
 }
 
 class ViewController: UIViewController {
 
 // MARK: - iVAR - CONSTANT - IB
 @IBOutlet weak var navigationItemcustom: UINavigationItem! // NAVIGATION BAR
 @IBOutlet weak var tableView: UITableView! // TABLEVIEW FROM SB
 
 
 var defaultFirstHeaderRow: CGFloat = 60 // HEIGHT ROW : HEADER | FOOTER
 var defaultRestOfHeaderRow: CGFloat = 30
 var mailArray = [Mail]() // DATA HYDRATE TABLEVIEW
 var lastVerticalOffset: CGFloat = 0 // SCROLLING TABLEVIEW
 var headerViewOriginalHeight: CGFloat = 0
 let navBarAppearance = UINavigationBarAppearance() // SETTING | NAVIGATION ITEM / TITLE
 var topItemLabel = UILabel()
 
 override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
 return [.portrait, .landscape]
 }
 // MARK: - CYCLE LIFE
 override func viewDidLoad() {
 super.viewDidLoad()
 spinnerLoadingTableView() // set data
 //
 //        //setup
 setDataArrayMail()
 
 
 //        setUpNavigationItem()
 //        setUpViewToBlackColor()
 //        setUpNavigationItemForTopItem()
 
 
 //        navigationBarWhite()
 
 //        applyImageBackgroundToTheNavigationBar() // custom image for navbar transparency
 
 
 
 
 }
 
 
 
 // MARK: - SETTING | NAVIGATION ITEM
 fileprivate func setUpViewToBlackColor() {
 self.view.backgroundColor = UIColor.black
 self.tableView.backgroundColor = UIColor.black // view and tableView on top
 }
 fileprivate func setUpNavigationItem() {
 // set data
 navBarAppearance.configureWithTransparentBackground()
 navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
 navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
 }
 // not used
 func navigationBarWhite() {
 //MARK: -
 // FIXME: remettre sur clear par default
 navBarAppearance.backgroundColor = UIColor.clear
 navBarAppearance.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5)
 // MARK: -
 
 self.navigationItem.standardAppearance = navBarAppearance
 self.navigationItem.compactAppearance = navBarAppearance
 self.navigationItem.scrollEdgeAppearance = navBarAppearance
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
 self.navigationController!.navigationBar.alpha = 1
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
 
 
 
 
 
 
 */
 


