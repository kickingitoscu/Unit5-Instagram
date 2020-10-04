//
//  LoginViewController.swift
//  
//
//  Created by Mariana Duarte on 9/27/20.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var PasswordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButton(_ sender: Any) {
        let username = usernameField.text!
        let pw = PasswordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: pw) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
            else {
                
                print("Error \(Error.self)")
                
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        let user = PFUser()
        
        user.username = usernameField.text
        user.password = PasswordField.text
        user.signUpInBackground { (sucess, error) in
            
            if let error = error {
                print(error.localizedDescription)
                fatalError()
            }
            if sucess{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            
        }
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
