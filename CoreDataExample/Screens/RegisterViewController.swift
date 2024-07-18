//
//  RegisterViewController.swift
//  CoreDataExample
//
//  Created by Mayank Barnwal on 17/07/24.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    private let dbManager = DBManager()
    
    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user{
            let nameArr = user.name?.components(separatedBy: " ")
            fNameTextField.placeholder = nameArr!.count > 0 ? nameArr?[0] : ""
            lNameTextField.placeholder = nameArr!.count > 1 ? nameArr?[1] : ""
            emailTextField.placeholder = user.emailid
            passwordTextField.placeholder = user.password
            registerBtn.setTitle("Update", for: .normal)
        }
    }
    
    @IBAction func onRegisterBtn(_ sender: Any) {
        
        if let user{
            guard let firstName = fNameTextField.text else {
                openAlert(message: "First name can't be blank")
                return
            }
            guard let lastName = lNameTextField.text else {
                openAlert(message: "Last name can't be blank")
                return
            }
            guard let email = emailTextField.text else {
                openAlert(message: "Email id can't be blank")
                return
            }
            
            guard let password = passwordTextField.text else {
                openAlert(message: "Password can't be blank")
                return
            }
            
            let nameArr = user.name?.components(separatedBy: " ")
            let fname = nameArr!.count > 0 ? nameArr?[0] : ""
            let lname = nameArr!.count > 1 ? nameArr?[1] : ""
            
            let userData = UserModal.init(fName: (firstName == "" ? fname : firstName) ?? "",
                                          lName: (lastName == "" ? lname : lastName) ?? "",
                                          email: (email == "" ? user.emailid : email) ?? "",
                                          password: (password == "" ? user.password : password) ?? "")
            
            dbManager.updateData(userData, user)
        }else{
            
            guard let firstName = fNameTextField.text, !firstName.isEmpty else {
                openAlert(message: "First name can't be blank")
                return
            }
            guard let lastName = lNameTextField.text, !lastName.isEmpty else {
                openAlert(message: "Last name can't be blank")
                return
            }
            guard let email = emailTextField.text, !email.isEmpty else {
                openAlert(message: "Email id can't be blank")
                return
            }
            
            guard let password = passwordTextField.text, !password.isEmpty else {
                openAlert(message: "Password can't be blank")
                return
            }
            
            let userData = UserModal.init(fName: firstName, lName: lastName, email: email, password: password)
            
            dbManager.saveData(userData)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "User added", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }
    
    func openAlert(message: String){
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }
}


