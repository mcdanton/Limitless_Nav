//
//  Data.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/13/17.
//  Copyright © 2017 DH. All rights reserved.
//

import Foundation

class BinarySearchTree<T: Comparable> {
   
   // MARK: Properties
   private(set) public var value: T
   private(set) public var parent: BinarySearchTree?
   private(set) public var left: BinarySearchTree?
   private(set) public var right: BinarySearchTree?
   
   
   // MARK: Init
   public init(value: T) {
      self.value = value
      }
   
   // Init to create full tree
   public convenience init(array: [T]) {
      precondition(array.count > 0)
      self.init(value: array.first!)
      for v in array.dropFirst() {
         insert(value: v)
      }
   }
   
   
   // MARK: Computed Properties
   
   public var isRoot: Bool {
      return parent == nil
   }
   
   public var isLeaf: Bool {
      return left == nil && right == nil
   }
   
   public var isLeftChild: Bool {
      return parent?.left === self
   }
   
   public var isRightChild: Bool {
      return parent?.right === self
   }
   
   public var hasLeftChild: Bool {
      return parent?.left != nil
   }
   
   public var hasRightChild: Bool {
      return parent?.right != nil
   }
   
   public var hasAnyChild: Bool {
      return hasLeftChild || hasRightChild
   }
   
   public var hasBothChildren: Bool {
      return hasLeftChild && hasRightChild
   }
   
   public var count: Int {
      return (left?.count ?? 0) + 1 + (right?.count ?? 0)
   }
   
   // MARK: Class Functions
   
   public func insert(value: T) {
      if value < self.value {
         if let left = left {
            left.insert(value: value)
         } else {
            left = BinarySearchTree(value: value)
            left?.parent = self
         }
      } else {
         if let right = right {
            right.insert(value: value)
         } else {
            right = BinarySearchTree(value: value)
            right?.parent = self
         }
      }
   }
   
   public func search(value: T) -> BinarySearchTree? {
      if value < self.value {
         return left?.search(value: value)
      } else if value > self.value {
         return right?.search(value: value)
      } else {
         return self // found it!
      }
   }
   
   public func traverseInOrder(process: (T) -> Void) {
      left?.traverseInOrder(process: process)
      process(value)
      right?.traverseInOrder(process: process)
   }
   
   public func traversePreOrder(process: (T) -> Void) {
      process(value)
      left?.traversePreOrder(process: process)
      right?.traversePreOrder(process: process)
   }
   
   public func traversePostOrder(process: (T) -> Void) {
      left?.traversePostOrder(process: process)
      right?.traversePostOrder(process: process)
      process(value)
   }
   
   // To print out all the values of the tree sorted from low to high you can write: tree.traverseInOrder { value in print(value) }
   
}


extension BinarySearchTree: CustomStringConvertible {
   public var description: String {
      var s = ""
      if let left = left {
         s += "(\(left.description)) <- "
      }
      s += "\(value)"
      if let right = right {
         s += " -> (\(right.description))"
      }
      return s
   }
}







