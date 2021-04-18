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
        case 0:
            NotificationCenter.default.post(name: NSNotification.Name("showNote"), object: nil)
            //performSegue(withIdentifier: "showNote", sender: nil)
        case 1:
            NotificationCenter.default.post(name: NSNotification.Name("showReminder"), object: nil)
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name("showSignIn"), object: nil)
        default:break
        }
    }


}
