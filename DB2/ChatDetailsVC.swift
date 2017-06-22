//
//  ChatDetailsVC.swift
//  DB2
//
//  Created by Fedir Korniienko on 21.06.17.
//  Copyright © 2017 fedir. All rights reserved.
//

import UIKit

class ChatDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var inputMessage: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messageData = [Messages]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        self.tableView.register(UINib(nibName: "MyMessageCell", bundle: nil), forCellReuseIdentifier: "MyMessageCell")
        ServerManager.sharedManager.fetchDataWithEndPoint(type: MessageBase.init(json: nil), endPoint: .message) { (data, error) in
            if let data = data as? MessageBase{
                self.messageData = data.messages
                self.tableView.reloadData()
            }
        
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageData.count != 0 ? messageData.count : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messageData.count == 0 {return UITableViewCell()}
        
        let message = messageData[indexPath.row]
        switch indexPath.row%2 {
        case 0:
            if let cell: MessageCell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell {
                cell.message.text = message.text
                cell.imageUser.sd_setImage(with: URL(string: (message.sender?.photo)!) , placeholderImage: #imageLiteral(resourceName: "no_avatar"))
                let date = message.create_date.toDateTime().formattedDate(withFormat: "HH:mm")
                cell.time.text = String(describing: date! )
                return cell
            }
        case 1:
            if let cell: MyMessageCell = tableView.dequeueReusableCell(withIdentifier: "MyMessageCell") as? MyMessageCell {
                cell.message.text = message.text
                let date = message.create_date.toDateTime().formattedDate(withFormat: "HH:mm")
                cell.time.text = String(describing: date!)
                return cell
            }
        default:
            break
        }
        

        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func keyboardWillShow(notification: NSNotification) {
        var userInfo = notification.userInfo!
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        self.view.frame = CGRect(x: 0, y: -keyboardSize.height, width: self.view.frame.width, height: self.view.frame.height)
        
        
       
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let contentInset: UIEdgeInsets = .zero
        var userInfo = notification.userInfo!
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)    }
}
