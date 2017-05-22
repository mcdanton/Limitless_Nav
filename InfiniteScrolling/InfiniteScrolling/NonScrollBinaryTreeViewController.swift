//
//  NonScrollBinaryTreeViewController.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 5/17/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit



class NonScrollBinaryTreeViewController: UIViewController {
   
   
   @IBOutlet weak var screenLabel: UILabel!
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      navigationController?.isNavigationBarHidden = true
      
      if let label = BinaryTree.sharedInstance.currentNode?.value {
         self.screenLabel.text = "This node is: \(label)"
      } else {
         if let rootNode = BinaryTree.sharedInstance.rootNode?.value {
            self.screenLabel.text = "This node is: \(rootNode)"
         }
      }
      
      addGestures()
      
   }
   
   
   
   func addGestures() {
      
      let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(switchScreens))
      swipeLeft.direction = .left
      self.view.addGestureRecognizer(swipeLeft)
      
      let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(switchScreens))
      swipeDown.direction = .down
      self.view.addGestureRecognizer(swipeDown)
   }
   
   
   
   func switchScreens(gesture: UIGestureRecognizer) {
      
      if let swipeGesture = gesture as? UISwipeGestureRecognizer {
         
         BinaryTree.sharedInstance.screenWasSwiped(theCurrentNode: BinaryTree.sharedInstance.currentNode, swipeGesture: swipeGesture, navController: navigationController)
         
      }
   }
   
   
   
   
   //   func switchScreens(gesture: UIGestureRecognizer) {
   //
   //      if let swipeGesture = gesture as? UISwipeGestureRecognizer {
   //
   //         switch swipeGesture.direction {
   //         case UISwipeGestureRecognizerDirection.down:
   //            print("Swiped down")
   //
   //            if let node = newTree.currentNode {
   //               if let leftChild = node.leftChild {
   //                  print("Left Child exists")
   //                  let newVC = NonScrollBinaryTreeViewController()
   //                  newVC.view.backgroundColor = UIColor.yellow
   //                  navigationController?.pushViewController(newVC, animated: true)
   //                  newTree.currentNode = leftChild
   //
   //               }
   //            } else {
   //               newTree.currentNode = newTree.rootNode
   //               if let leftChild = newTree.currentNode?.leftChild {
   //                  print("Left Child exists")
   //                  let newVC = NonScrollBinaryTreeViewController()
   //                  newVC.view.backgroundColor = UIColor.yellow
   //                  navigationController?.pushViewController(newVC, animated: true)
   //                  newTree.currentNode = leftChild
   //               }
   //            }
   //
   //         case UISwipeGestureRecognizerDirection.left:
   //            print("Swiped left")
   //
   //            if let node = newTree.currentNode {
   //               if let rightChild = node.rightChild {
   //                  print("Right Child exists")
   //                  print("current Node is: \(node.value)")
   //                  print("rightChild Node is: \(rightChild.value)")
   //                  let newVC = NonScrollBinaryTreeViewController()
   //                  newVC.view.backgroundColor = UIColor.cyan
   //                  navigationController?.pushViewController(newVC, animated: true)
   //                  newTree.currentNode = rightChild
   //
   //               }
   //            } else {
   //               newTree.currentNode = newTree.rootNode
   //               if let rightChild = newTree.currentNode?.rightChild {
   //                  print("Right Child exists")
   //                  let newVC = NonScrollBinaryTreeViewController()
   //                  newVC.view.backgroundColor = UIColor.cyan
   //                  navigationController?.pushViewController(newVC, animated: true)
   //                  newTree.currentNode = rightChild
   //               }
   //            }
   //            
   //         default:
   //            break
   //         }
   //      }
   //   }
   
}
