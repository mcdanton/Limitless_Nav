//
//  Model.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/6/17.
//  Copyright © 2017 DH. All rights reserved.
//

import Foundation



class Node<T> {
   
   var value: T
   var children: [Node] = []
   weak var parent: Node?
   
   init(value: T) {
      self.value = value
      


   }
   
   
   func addChild(child: Node) {
      children.append(child)
      child.parent = self
   }
}


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










