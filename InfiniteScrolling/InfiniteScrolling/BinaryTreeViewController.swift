//
//  BinaryTreeViewController.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 5/16/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class BinaryTreeViewController: UIViewController, UIScrollViewDelegate {
   
   // MARK: Outlets
   
   @IBOutlet var superView: UIView!
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var contentView: UIView!
   @IBOutlet weak var pageControl: UIPageControl!
   
   // MARK: Properties
   var currentNode: Node?
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
      navigationController?.isNavigationBarHidden = true
      scrollView.delegate = self
      
      let newTree = BinaryTree()
      newTree.createTree(nodesInTree: [
         Node(value: 40),
         Node(value: 20),
         Node(value: 130),
         Node(value: 80),
         Node(value: 100),
   ])
      
      scrollView.contentSize = CGSize(width: contentView.frame.width * CGFloat(newTree.count!), height: view.frame.height)
      scrollView.isPagingEnabled = true


      addPages(tree: newTree)
      
   }
   
   
   func addPages(tree: BinaryTree) {
      
      for node in 1...tree.count! {
         
         let newView = UIView(frame: CGRect(x: view.frame.width * CGFloat(node), y: 0, width: view.frame.width, height: view.frame.height))
         newView.backgroundColor = UIColor.random()
         contentView.addSubview(newView)
//         newView.tag = tree[node].value
      }
      scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(tree.count!), height: view.frame.height)
      pageControl.numberOfPages = tree.count!
      currentNode = tree.rootNode
   }
   

   func addGestures() {
      let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(switchScreens))
      swipeDown.direction = .down
      self.view.addGestureRecognizer(swipeDown)
      
      let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(switchScreens))
      swipeLeft.direction = .left
      self.view.addGestureRecognizer(swipeLeft)
   }
   
   
   func switchScreens(gesture: UIGestureRecognizer) {
      
      if let swipeGesture = gesture as? UISwipeGestureRecognizer {
         
         switch swipeGesture.direction {
         case UISwipeGestureRecognizerDirection.down:
            print("Swiped down")
         case UISwipeGestureRecognizerDirection.left:
            print("Swiped left")
//            UIView.animate(withDuration: 1.0, animations: {
//               
//               // NEED TO MAKE THIS SELF WEAK
//               if let currentNode = self.currentNode {
//                  if currentNode.rightChild != nil {
//                     
//                  }
//                  
//               }
//               
//               self.newView?.frame = self.view.frame
//               self.newView?.backgroundColor =  UIColor.cyan
//               self.activeView = self.newView
//            }, completion: nil)
         default:
            break
         }
      }
   }
   



}
