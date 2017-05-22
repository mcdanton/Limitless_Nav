//
//  Model.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/6/17.
//  Copyright © 2017 DH. All rights reserved.
//

import Foundation
import Analytics


class BinaryTree {
   
   static let sharedInstance = BinaryTree()
   
   var rootNode: Node?
   var currentNode: Node?
   public var count: Int? {
      if let rootNode = rootNode {
         return rootNode.count
      } else {
         return 0
      }
   }
   
   
    init () {
      createTree(nodesInTree: [
         Node(value: 100),
         Node(value: 140),
         Node(value: 80),
         Node(value: 110),
         Node(value: 70),
         Node(value: 190),
         Node(value: 40),
         Node(value: 50),
         Node(value: 10),
         Node(value: 120),
         Node(value: 130),
         ])
   }
   
   
   func insertNode(node: Node) {
      
      if rootNode == nil {
         rootNode = node
      } else {
         rootNode?.addNode(node: node)
      }
   }
   
   
   func createTree(nodesInTree: [Node]) {
      
      for node in nodesInTree {
         insertNode(node: node)
      }
   }
   
   func screenWasSwiped(theCurrentNode: Node?, swipeGesture: UISwipeGestureRecognizer, navController: UINavigationController?) {

      
      switch swipeGesture.direction {
      case UISwipeGestureRecognizerDirection.down:
         print("Swiped down")
         
         if let node = currentNode {
            if let leftChild = node.leftChild {
               print("Left Child exists")
               
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: "NonScrollBinaryTreeVC")
               navController?.pushViewController(controller, animated: true)
               self.currentNode = leftChild
               
            }
         } else {
            self.currentNode = self.rootNode
            if let leftChild = self.currentNode?.leftChild {
               print("Left Child exists")
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: "NonScrollBinaryTreeVC")
               navController?.pushViewController(controller, animated: true)
               self.currentNode = leftChild
            }
         }
         
      case UISwipeGestureRecognizerDirection.left:
         print("Swiped left")
         if let node = currentNode {
            if let rightChild = node.rightChild {
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: "NonScrollBinaryTreeVC")
               navController?.pushViewController(controller, animated: true)
               self.currentNode = rightChild
            }
         } else {
            self.currentNode = self.rootNode
            if let rightChild = self.currentNode?.rightChild {
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: "NonScrollBinaryTreeVC")
               navController?.pushViewController(controller, animated: true)
               self.currentNode = rightChild
            }
         }
      default:
         break
      }
      
      print("current Node is: \(currentNode?.value)")
      print("rightChild Node is: \(currentNode?.rightChild?.value)")
      print("leftChild Node is: \(currentNode?.leftChild?.value)")
      
      
   }
   
   
   // This function takes in a direction, 0 - left, 1 - right, and an ID of a Node and will return an array of Nodes from all the children of the current Node based on the direction chosen
   
   func getArrayOfChildNodes(direction: Int, myCurrentNode: Node) -> [Node]? {
      
      var arrayOfChildNodes: [Node]?
      switch direction {
      case 0:
         var myNode = myCurrentNode
         while myNode.leftChild != nil {
            arrayOfChildNodes?.append(myNode.leftChild!)
            myNode = myNode.leftChild!
         }
      case 1:
         var myNode = myCurrentNode
         while myNode.rightChild != nil {
            arrayOfChildNodes?.append(myNode.rightChild!)
            myNode = myNode.rightChild!
         }
      default:
         break
      }
      return arrayOfChildNodes
   }
   
   
}




class Node {
   
   var value: Int
   var leftChild: Node?
   var rightChild: Node?
   weak var parent: Node?
   
   init(value: Int) {
      self.value = value
   }
   
   
   func addNode(node: Node) {
      if node.value < self.value {
         if let left = leftChild {
            left.addNode(node: node)
         } else {
            leftChild = Node(value: node.value)
            leftChild?.parent = self
         }
      } else {
         if let right = rightChild {
            right.addNode(node: node)
         } else {
            rightChild = Node(value: node.value)
            rightChild?.parent = self
         }
      }
   }
   
   
   public var count: Int {
      return (leftChild?.count ?? 0) + 1 + (rightChild?.count ?? 0)
   }
   
   
   
}






/*
 extension Node: CustomStringConvertible {
 
 var description: String {
 var text = "\(value)"
 
 if !children.isEmpty {
 text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
 
 //            text += " {"
 //            for child in children {
 //               text += child.description + ", "
 //            }
 //            text += "} "
 //         }
 }
 return text
 }
 }
 
 
 extension Node where T: Equatable {
 // 1
 func search(value: T) -> Node? {
 // 2
 if value == self.value {
 return self
 }
 // 3
 for child in children {
 if let found = child.search(value: value) {
 return found
 }
 }
 // 4
 return nil
 }
 }
 */









