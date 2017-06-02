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
   
   let width = 128
   
   
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
         Node(value: 150),
         Node(value: 50),
         Node(value: 25),
         Node(value: 75),
         Node(value: 125),
         Node(value: 175),
         Node(value: 115),
         Node(value: 135),
         Node(value: 165),
         Node(value: 185),
         Node(value: 15),
         Node(value: 35),
         Node(value: 65),
         Node(value: 85),
         Node(value: 10),
         Node(value: 20),
         Node(value: 30),
         Node(value: 40),
         Node(value: 63),
         Node(value: 70),
         Node(value: 80),
         Node(value: 95),
         Node(value: 110),
         Node(value: 120),
         Node(value: 130),
         Node(value: 140),
         Node(value: 163),
         Node(value: 170),
         Node(value: 180),
         Node(value: 195),
         Node(value: 5),
         Node(value: 12),
         Node(value: 17),
         Node(value: 22),
         Node(value: 27),
         Node(value: 33),
         Node(value: 37),
         Node(value: 45),
         ])
      currentNode = rootNode
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
   }
   
   
   
   
   
   // This function takes in a direction, 0 - left, 1 - right, and an ID of a Node and will return an array of Nodes from all the children of the current Node based on the direction chosen
   
   func getArrayOfChildNodes(direction: Int, myCurrentNode: Node) -> [Node] {
      
      var arrayOfChildNodes = [Node]()
      switch direction {
      case 0:
         var myNode = myCurrentNode
         while myNode.leftChild != nil {
            arrayOfChildNodes.append(myNode.leftChild!)
            //            print(myNode.leftChild!.value)
            myNode = myNode.leftChild!
         }
      case 1:
         var myNode = myCurrentNode
         while myNode.rightChild != nil {
            arrayOfChildNodes.append(myNode.rightChild!)
            //            print(myNode.rightChild!.value)
            myNode = myNode.rightChild!
         }
      default:
         break
      }
      return arrayOfChildNodes
   }
   
   

   
   func returnDepth() ->  Int  {
      return 5
   }
   
   func printIndent(indent: Int) {
      
      if(indent == 0) {
         return
      }
      
      var spaceToPrint = "_"
      
      for i in 1..<indent {
         spaceToPrint += "_"
      }
      print(spaceToPrint,terminator:"")
      

   }

   
   func DebugTree(node: [Node], depth : Int) {
      
      var blankarray = true;
      
      for n in node {
         if(n.value > 0) {
            blankarray = false;
         }
      }
      
      if(blankarray) {
         return
      }
      
      
      let spacing = (Int)(width / (node.count * 2))
      
      var children = [Node]()
      
      for (index, n) in node.enumerated() {
         
         if( index == 0) {
            n.printNode(indent: spacing)
         } else {
            n.printNode(indent: (spacing * 2))
         }
         
         print("", terminator : "")
         // last item
         if(index == node.count - 1) {
            print("-")
         }
         
         // create the next array
         if (n.leftChild != nil) {
            children.append(n.leftChild!)
         } else {
            children.append(Node(value: -1));
         }
         if (n.rightChild != nil) {
            children.append(n.rightChild!)
         } else {
            children.append(Node(value: -1));
         }
         
      
      }
      
      DebugTree(node:children, depth: depth + 1);
      
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
   
   
   func printNode(indent: Int?) {
      
      var spaceToPrint = ""
      
      let spacinglength = indent! - self.value.description.characters.count

      if indent != nil {
         for i in 0..<spacinglength {
            spaceToPrint += "_"
         }
         print("\(spaceToPrint)\(self.value)",terminator:"")
      }
   }
   
   
}


