//
//  LoginViewModel.swift
//  PostAndFavorites
//
//  Created by Yuvaraju V on 20/02/21.
//

import UIKit

protocol ValidationViewModel {
  func inValidUser(error: String) -> Void
  func presentHomeVC() -> Void
}

class LoginViewModel {
  
  var delegate: ValidationViewModel?
  
  func checkUserInputFields(mailId: String, password: String) {
    let format = StringConstants.format
    let regx = StringConstants.regx
    
    if mailId.isEmpty && password.isEmpty {
      delegate?.inValidUser(error: StringConstants.emptyCredential)
      return
    }
    
    if !NSPredicate(format: format, regx).evaluate(with: mailId) {
      delegate?.inValidUser(error: StringConstants.emptymailID)
      return
    }
    
    if !(password.count >= 8 && password.count <= 15) {
      delegate?.inValidUser(error: StringConstants.emptyPassword)
      return
    }
    navigateToHomeVC()
    
  }
  
  func navigateToHomeVC() {
    delegate?.presentHomeVC()
  }
  
}

