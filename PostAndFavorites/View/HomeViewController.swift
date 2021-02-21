//
//  HomeViewController.swift
//  PostAndFavorites
//
//  Created by Yuvaraju V on 21/02/21.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  
  var postArray = [Post]()
  var favouriteArray = [Post]()
  
  var homeViewModel: HomeViewModel!
  
  var tag = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    homeViewModel = HomeViewModel()
    homeViewModel.delegate = self
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    homeViewModel.getPostData()
  }
  
  func setupUI() {
    tag = 0
    self.title = StringConstants.homeVCTitle
    navigationController?.isNavigationBarHidden = false
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 120
    tableView.tableFooterView = UIView()
    self.navigationItem.setHidesBackButton(true, animated: false)
    let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action:  #selector(logoutButtonClicked))
    self.navigationItem.rightBarButtonItem  = logoutButton
  }
  
  
  @objc func logoutButtonClicked() {
    let alert = UIAlertController(title: StringConstants.alert, message: StringConstants.logoutMessage, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: StringConstants.ok, style: .default) {_ in
      self.navigationController?.popViewController(animated: true)
    }
    alert.addAction(okAction)
    let cancelAction = UIAlertAction(title: StringConstants.cancel, style: .default) {
      UIAlertAction in
    }
    alert.addAction(cancelAction)
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func onSegmentControlStatusChange(_ sender: UISegmentedControl) {
    tag = sender.selectedSegmentIndex
    tableView.reloadData()
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    var numberOfSection = 0
    if (self.tag == 0 && postArray.count != 0) || (self.tag == 1 && favouriteArray.count != 0) {
      tableView.separatorStyle = .singleLine
      tableView.backgroundView = nil
     numberOfSection = 1
    } else {
      let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
      noDataLabel.numberOfLines = 0
      noDataLabel.text = StringConstants.noDataMsg
      noDataLabel.textColor =  UIColor.black
      noDataLabel.textAlignment = .center
      self.tableView.backgroundView  = noDataLabel
      self.tableView.separatorStyle  = .none
    }
    return numberOfSection
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (self.tag == 0) ? postArray.count : favouriteArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.cellIndentifier) as! PostsTableViewCell
    
    let post = (self.tag == 0) ? postArray[indexPath.row] : favouriteArray[indexPath.row]
    
    cell.postTitleLabel.text = post.title
    cell.postBodyLabel.text = post.body
    cell.segementIndex = self.tag
    
    if (self.favouriteArray.filter { $0.title == post.title}.count != 0)  {
      cell.favouriteButton.setImage(UIImage(named: StringConstants.filledStar), for: .normal)
    } else {
      cell.favouriteButton.setImage(UIImage(named: StringConstants.star), for: .normal)
    }
    
    cell.favouriteCallback = { (isFavouritePost) in
      self.favouriteArray = self.homeViewModel.favouriteData(favouriteArray: &self.favouriteArray, post: post, isFavouritePost: isFavouritePost)
    }
    return cell
  }
}

extension HomeViewController: HomeViewModelProtocol {
  func reloadTableView(postData: [Post]) {
    self.postArray = postData
    self.tableView.reloadData()
  }
}
