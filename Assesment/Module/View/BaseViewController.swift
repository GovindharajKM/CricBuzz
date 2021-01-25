//
//  BaseViewController.swift
//  Assesment
//
//  Created by Govindharaj Murugan on 20/01/21.
//

import UIKit
import AssesmentProfileModule

class BaseViewController: UIViewController {
    
    var btnTheme = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnTheme = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        self.btnTheme.addTarget(self, action: #selector(self.btnThemeChange_Click(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.btnTheme)
        navigationController?.navigationBar.barTintColor = ThemeModel.viewBgColor
        navigationController?.navigationBar.tintColor = ThemeModel.textColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: ThemeModel.textColor]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ThemeModel.isDarkModeEnabled {
            self.btnTheme.setImage(#imageLiteral(resourceName: "light"), for: .normal)
        } else {
            self.btnTheme.setImage(#imageLiteral(resourceName: "dark"), for: .normal)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    var style: UIStatusBarStyle = .default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    
    @objc func btnThemeChange_Click(_ sender: UIButton) {
    
        if !ThemeModel.isDarkModeEnabled {
            self.btnTheme.setImage(#imageLiteral(resourceName: "light"), for: .normal)
            ThemeModel.changeTheme(.dark)
            self.style = .lightContent
        } else {
            ThemeModel.changeTheme(.light)
            self.btnTheme.setImage(#imageLiteral(resourceName: "dark"), for: .normal)
            self.style = .default
        }
        
        // Post notification
        NotificationCenter.default.post(name: .notificationThemeChange, object: nil, userInfo: ["theme": ThemeModel.isDarkModeEnabled ? true : false])
    }
}
