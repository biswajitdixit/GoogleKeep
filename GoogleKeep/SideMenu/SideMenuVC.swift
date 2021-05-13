//
//  SideMenuVC.swift
//  GoogleKeep
//
//  Created by admin on 17/04/21.
//

import UIKit

class SideMenuVC: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name("showSideMenu"), object: nil)
        
        switch indexPath.row {
        case 1:
            NotificationCenter.default.post(name: NSNotification.Name("showReminder"), object: nil)
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name("showArchive"), object: nil)
        case 3:
            NotificationCenter.default.post(name: NSNotification.Name("showDelete"), object: nil)
        case 4:
            NotificationCenter.default.post(name: NSNotification.Name("showSignIn"), object: nil)
        default:break
        }
    }


}
