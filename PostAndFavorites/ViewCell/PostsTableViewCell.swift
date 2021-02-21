//
//  PostsTableViewCell.swift
//  PostAndFavorites
//
//  Created by Yuvaraju V on 21/02/21.
//

import UIKit

typealias FavouriteCallback = ((_ isFavouritePost: Bool) -> ())

class PostsTableViewCell: UITableViewCell {
  @IBOutlet var postTitleLabel: UILabel!
  @IBOutlet var postBodyLabel: UILabel!
  @IBOutlet var favouriteButton: UIButton!
  
  var favouriteCallback: FavouriteCallback?
  var segementIndex: Int?

  @IBAction func favouriteButtonClicked(_ sender: UIButton) {
    guard let segementIndex = segementIndex, segementIndex == 0 else {
      return
    }
    if favouriteButton.currentImage == UIImage(named: "star") {
      favouriteButton.setImage(UIImage(named: "filledStar"), for: .normal)
      favouriteCallback!(true)
    } else {
      favouriteButton.setImage(UIImage(named: "star"), for: .normal)
      favouriteCallback!(false)
    }
  }
  
}
