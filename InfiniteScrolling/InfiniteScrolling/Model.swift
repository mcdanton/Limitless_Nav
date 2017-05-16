//
//  Model.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/6/17.
//  Copyright © 2017 DH. All rights reserved.
//

import Foundation
import Analytics


class Node {
   
   var uID: Int
   var leftChild: Node?
   var rightChild: Node?
   weak var parent: Node?
   
   init(uID: Int) {
      self.uID = uID
   }
   
   
   func addChildren(children: [Node]) {
      
      for node in children {
         if let parent = node.parent {
            if node.uID < parent.uID {
               parent.leftChild = node
            } else {
               parent.rightChild = node
            }
         }
      }
   }
   
}




/*
extension Node: CustomStringConvertible {
   
   var description: String {
      var text = "\(uID)"
      
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









