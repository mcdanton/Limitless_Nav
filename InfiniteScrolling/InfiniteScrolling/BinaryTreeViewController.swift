//
//  BinaryTreeViewController.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 5/16/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class BinaryTreeViewController: UIViewController {
   
   

   
    override func viewDidLoad() {
        super.viewDidLoad()
      
      var newTree = BinaryTree()
      newTree.createTree(nodesInTree: [
         Node(value: 40),
         Node(value: 20),
         Node(value: 130),
         Node(value: 80),
         Node(value: 100),
   ])
      
      newTree.count!
      
   }



}
