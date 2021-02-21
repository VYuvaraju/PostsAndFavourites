//
//  APIService.swift
//  PostAndFavorites
//
//  Created by Yuvaraju V on 21/02/21.
//

import UIKit
import Alamofire

class APIService : NSObject {
  public func getPostData(url: String, completion : @escaping ([Post]) -> ()) {
    if let url = URL(string: url) {
      Alamofire.request(url).response { (response) in
        let data = response.data
        do {
          completion(try JSONDecoder().decode([Post].self, from: data!))
        } catch {
          completion([])
        }
      }
    }
  }
}
