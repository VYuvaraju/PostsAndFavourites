//
//  HomeViewModel.swift
//  PostAndFavorites
//
//  Created by Yuvaraju V on 21/02/21.
//

import UIKit

protocol HomeViewModelProtocol {
  func reloadTableView(postData: [Post]) -> Void
}

class HomeViewModel {
  
  var delegate: HomeViewModelProtocol?
  
  func getPostData() {
    APIService().getPostData(url: StringConstants.postURL) { postData in
      self.delegate?.reloadTableView(postData: postData)
    }
  }
  
  func favouriteData(favouriteArray: inout [Post], post: Post, isFavouritePost: Bool) -> [Post] {
    if isFavouritePost {
      if (favouriteArray.filter { $0.title == post.title}.count == 0) {
        favouriteArray.append(post)
      }
    } else {
      if let index = favouriteArray.firstIndex(where: {$0.title == post.title}) {
        favouriteArray.remove(at: index)
      }
    }
    return favouriteArray
  }
  
  
  
}
