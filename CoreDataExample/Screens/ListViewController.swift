//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Mayank Barnwal on 17/07/24.
//

import UIKit


class ListViewController: UIViewController {

    @IBOutlet weak var containerTableView: UITableView!
    
    private lazy var userArray:[User] = []{
        didSet{
            containerTableView.reloadData()
        }
    }
    
    private var dbManager = DBManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userArray = dbManager.getUsers()
    }

    @IBAction func onRegisterBtn(_ sender: Any) {
        performSegue(withIdentifier: "OpenRegisterView", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userArray = dbManager.getUsers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenRegisterView" && sender != nil{
            if let registerViewController = segue.destination as? RegisterViewController{
                registerViewController.user = sender as? User
            }
        }
    }
}


extension ListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration ()
        let user = userArray[indexPath.row]
        content.text = user.name
        content.secondaryText = user.emailid
        
        cell.contentConfiguration = content
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "OpenRegisterView", sender: userArray[indexPath.row])
    }
}
