//
//  Post.swift
//  PostAndFavorites
//
//  Created by Yuvaraju V on 21/02/21.
//

import Foundation

struct Post: Decodable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}
