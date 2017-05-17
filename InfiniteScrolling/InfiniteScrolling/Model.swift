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
   
   var rootNode: Node?
   public var count: Int? {
      if let rootNode = rootNode {
         return rootNode.count
      } else {
         return 0
      }
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
         if let left = node.leftChild {
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









