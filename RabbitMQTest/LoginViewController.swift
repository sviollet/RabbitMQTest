//
//  LoginViewController.swift
//  Alarm
//
//  Created by samuel on 04/04/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func editingChanged(_ sender: Any) {
        
        loginButton.isEnabled = (loginTextField.text != nil)
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        
        AlarmeSystem.shared.user = loginTextField.text.unsafelyUnwrapped
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
