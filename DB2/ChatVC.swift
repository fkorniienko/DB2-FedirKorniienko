//
//  ViewController.swift
//  DB2
//
//  Created by Fedir Korniienko on 21.06.17.
//  Copyright © 2017 fedir. All rights reserved.
//

import UIKit
import SDWebImage
import DateTools

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tableDataChanel : [Channels]?
    var usersData = [Users]()
    var usersImage = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tableView.delegate = self
        tableView.dataSource = self

        self.tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")

        ServerManager.sharedManager.fetchDataWithEndPoint(type: BaseChat.init(json: nil), endPoint: .chat) { (data, error) in
            if let data = data as? BaseChat{
                self.tableDataChanel = data.channels
                let a = self.tableDataChanel!.map{i in i.users}

                for  x in 0..<a.count {
                    var line = ""
                    for  y in 0..<a[x].count {
                       self.usersData.append(a[x][y])
                        line += " "
                    }
                    print(line)
                }
                self.tableView.reloadData()
            }

        }
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usersData.count != 0 ? usersData.count : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if usersData.count == 0 {return UITableViewCell()}
        
        let user = usersData[indexPath.row]
        let data = tableDataChanel![indexPath.row/2]
        
        if let cell: ChatCell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as? ChatCell {
            cell.name.text = user.first_name + " " + user.last_name
            let date = data.last_message!.create_date.toDateTime().formattedDate(withFormat: "yyyy-MM-dd")
            
            cell.date.text = String(describing: date! )
            cell.count.text = String(data.unread_messages_count)
            cell.message.text = data.last_message!.text
            cell.imageUser.sd_setImage(with:  URL(string: user.photo)!, placeholderImage: #imageLiteral(resourceName: "no_avatar"), options: [])
            
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            usersData.remove(at: indexPath.row)
            if tableDataChanel![indexPath.row/2].users.count == 0{
            tableDataChanel?.remove(at: indexPath.row/2)
            }
            tableDataChanel![indexPath.row/2].users.remove(at: tableDataChanel![indexPath.section/2].users.count == 1 ? 0 : indexPath.row%2)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
            self.tableView.reloadData()

            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ChatDetailsVC") as? ChatDetailsVC {
            let user = usersData[indexPath.row]
            let title = user.first_name + " " + user.last_name
            destinationVC.navigationItem.title = title

            self.navigationController?.pushViewController(destinationVC, animated: true)

        
        }
    }

}


