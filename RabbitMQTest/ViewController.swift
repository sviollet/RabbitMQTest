//
//  ViewController.swift
//  Alarm
//
//  Created by samuel on 28/03/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import UIKit
import RMQClient

class ViewController: UIViewController {
    
    static let identifier: String = "tchatViewController"
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var editMessage: UITextField!
    @IBOutlet weak var tchatView: UIView!
    @IBOutlet weak var messagesListView: UIView!
    @IBOutlet weak var MessagesView: UIView!
    
    //=== PRIVATE ====================================
    private var keyboardOpen: Bool = false
    private var _dataSource: DataSource? = nil
    
    
    private var _messagesViewController : MessagesTableViewController?
    private var messagesViewController: MessagesTableViewController? {
        
        get { return self._messagesViewController }
        
        set(newValue) {
            if (newValue != self._messagesViewController) {
        
                self._messagesViewController = newValue
                self._messagesViewController?.delegate = self.delegate
                self._messagesViewController!._dataSource = DataSource()
            }
        }
    }
    
    //================================================
    
    //=== PUBLIC =====================================
    var delegate: TchatDelegate? {
        
        didSet(newValue) {
            self.messagesViewController?.delegate = self.delegate
            self.messagesViewController?.refreshUI()
        }
    }
    //================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _dataSource = DataSource()
        
        // Do any additional setup after loading the view, typically from a nib.

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: .UIKeyboardWillShow,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: .UIKeyboardWillHide,
            object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = self.delegate?.topic
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self._dataSource?.dispose()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func send(_ sender: Any) {
        
        if (!editMessage.text!.isEmpty) {
            
            _dataSource?.sendRequest(editMessage.text!, routingKey: delegate!.getKey())
            editMessage.text = ""
        }
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        (!self.keyboardOpen) ? self.moveKeyboard(notification: notification) : print("nothing to do")
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        (self.keyboardOpen) ? self.moveKeyboard(notification: notification) : print("nothing to do")

    }
    
    func moveKeyboard(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        let kbSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! CGRect).size
        
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect)
        let keyboard = self.view.convert(keyboardFrame, from: self.view.window)
        let height = self.view.frame.size.height
        /*
         CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect keyboard = [self.view convertRect:keyboardFrame fromView:self.view.window];
        CGFloat height = self.view.frame.size.height;
        */
        
        if ((keyboard.origin.y + keyboard.size.height) > height) {
            self.keyboardOpen = !self.keyboardOpen;
            
            (self.keyboardOpen) ? self.genericMoveKeyBoard(keyboardHeight: -kbSize.height) : self.genericMoveKeyBoard(keyboardHeight: kbSize.height)
        }
    }
    
    func genericMoveKeyBoard(keyboardHeight: CGFloat) {
        
        self.tchatView.frame.origin = CGPoint(x:self.tchatView.frame.origin.x, y: self.tchatView.frame.origin.y + keyboardHeight)
        self.messagesListView.frame.size.height = self.messagesListView.frame.size.height + keyboardHeight
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        
        self.scrollView.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.messagesViewController = segue.destination as! MessagesTableViewController
    }
    
    

}

