//
//  ContactsTableViewController.swift
//  Alarm
//
//  Created by samuel on 04/04/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import UIKit
import Dip


class ContactsTableViewController: UITableViewController, TchatDelegate {
    
    private let _cellName: String = "userCell"

    private var _service = AlarmeSystem.shared.userService.unsafelyUnwrapped
    
    private var _users: [(key: String, value: User)] = []
    
    internal var topic: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _service.load(completionHandler: {users in
            
            self._users = self._service.getUsers()
            self.tableView.reloadData()
        })
        
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self._users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self._cellName, for: indexPath)
        
        let user = self._users[self._users.index(self._users.startIndex, offsetBy: indexPath.row)]
        
        cell.textLabel?.text = user.value.name
        cell.detailTextLabel?.text = user.key

        return cell
    }
    
    func getKey() -> String {
        return DataSource.KEY_ROOT + "." + self.topic + "." + DataSource.KEY_MESSAGE
    }
    
    @IBAction func logout(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (splitViewController != nil) {
            self.topic = self._users[self._users.index(self._users.startIndex, offsetBy: indexPath.row)].key
            
            let navigationController = splitViewController?.viewControllers.last as! UINavigationController
            let tchatViewController = navigationController.topViewController as! ViewController
            tchatViewController.delegate = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
        self.topic = self._users[self._users.index(self._users.startIndex, offsetBy: (indexPath?.row)!)].key
        
        let tchatViewController: ViewController = segue.destination as! ViewController
        tchatViewController.delegate = self
        
    }

}
