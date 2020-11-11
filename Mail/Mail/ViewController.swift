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
    @IBOutlet weak var tableView: UITableView!
    
    var mailArray: [Mail] = []
    var defaultFirstHeaderRow: CGFloat = 1 // HEIGHT ROW : HEADER 
    var defaultRestOfHeaderRow: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataArrayMail()
        self.title = mailArray[0].title
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setDataArrayMail() {
        mailArray.append(Mail(title: "Boîtes", detail:["-Toutes les boites","-iCloud","-Gmail","-Yahoo","-VIP", "-Special"]))
        mailArray.append(Mail(title: "ACTION MAIL", detail:["Reception","Brouillon","envoyé","Corbeille","Archive"]))
        mailArray.append(Mail(title: "ACTION MAIL", detail:["Reception","Brouillon","envoyé","Corbeille","Archive", "magie", "Draft", "mario"]))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = mailArray[indexPath.section].detail?[indexPath.row]
        return cell
    }
}

// MARK: - Header, Footer
extension ViewController {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mailArray[section].title
    }
    // footer tableview
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        
        v.backgroundColor = .red
        return v
    }
}

// MARK: - HEIGHT ROW : FOOTER
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
 
 var refreshControl = UIRefreshControl() // SPINNER RELOAD DATA
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
 
 
 
 
 */
 


