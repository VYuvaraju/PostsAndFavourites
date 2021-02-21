//
//  LoginViewController.swift
//  PostAndFavorites
//
//  Created by Yuvaraju V on 20/02/21.
//

import UIKit

class LoginViewController: UIViewController, ValidationViewModel {

  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var mailIdTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var loginButton: UIButton!
  
  var loginViewModel: LoginViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loginViewModel = LoginViewModel()
    loginViewModel.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setupUI()
  }

  func setupUI() {
    self.navigationController?.isNavigationBarHidden = true
    
    contentView.layer.masksToBounds = true
    contentView.layer.cornerRadius = 12.0
    
    loginButton.layer.masksToBounds = true
    loginButton.layer.cornerRadius = 6.0
    
    mailIdTextField.delegate = self
    passwordTextField.delegate = self
    errorLabel.text = ""
    mailIdTextField.text = ""
    passwordTextField.text = ""
  }
  
  @IBAction func loginButtonClicked(_ sender: UIButton) {
    guard let mailId = mailIdTextField.text else {
      return
    }
    
    guard let password = passwordTextField.text else {
      return
    }
    
    loginViewModel.checkUserInputFields(mailId: mailId, password: password)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  func inValidUser(error: String) {
    errorLabel.text = error
  }
  
  func presentHomeVC() {
    let storyboard = UIStoryboard(name: StringConstants.storyBoardName, bundle: nil)
    let homeVC = storyboard.instantiateViewController(withIdentifier: StringConstants.homeVCIndentifier)
    self.navigationController?.pushViewController(homeVC, animated: true)
  }
}

extension LoginViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if errorLabel.text != "" {
      errorLabel.text = ""
    }
    return true
  }
}
