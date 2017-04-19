//
//  ViewController.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/6/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   override func viewDidLoad() {
      super.viewDidLoad()
      
      let tableView = UITableView()
      let rect = UIScreen.main.bounds
      tableView.frame = rect
      tableView.backgroundColor = UIColor.green
      
      self.view = tableView
      
      let newNode = Node(value: 5)
      
   }




}

