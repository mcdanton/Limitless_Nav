//
//  ProgrammaticScrollView.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 5/30/17.
//  Copyright © 2017 DH. All rights reserved.
//

import Foundation
import UIKit

class ProgrammaticScrollView: UIViewController, UIScrollViewDelegate {
   
   
   // MARK: Properties
   var scrollView : UIScrollView!
   var contentView : UIView!
   var pageControl: UIPageControl!
   var lastContentOffset = CGPoint()
   var directionScrolled: ScrollDirection = .none
   enum ScrollDirection {
      case none
      case left
      case right
      case down
      case up
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      scrollView = UIScrollView()
      scrollView.delegate = self
      contentView = UIView()

      
      firstLoad()
      
      
      scrollView.addSubview(contentView)
      view.addSubview(scrollView)

      
//      navigationController?.isNavigationBarHidden = true
      scrollView.isPagingEnabled = true
      scrollView.bounces = false
      scrollView.isDirectionalLockEnabled = true
//      scrollView.translatesAutoresizingMaskIntoConstraints = false
//
//      self.automaticallyAdjustsScrollViewInsets = false;
//      //      scrollView.contentInset = UIEdgeInsets.zero
//      //      scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
//      //      scrollView.contentOffset = CGPoint(x: 0, y: 0)
//      
//      pageControl.currentPage = 0
      
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      
      scrollView.frame = view.bounds
      contentView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
   }
   
   
   
   func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
      lastContentOffset = scrollView.contentOffset
   }
   
   func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      
      
      //      getScrollViewPage()
      
      
      if (lastContentOffset.x < scrollView.contentOffset.x) {
         directionScrolled = .right
         print("Scrolled Right")
         BinaryTree.sharedInstance.currentNode = BinaryTree.sharedInstance.currentNode?.rightChild
         reloadViews(directionSwiped: .right)
         //         getScrollViewPage()
      }
      else if (lastContentOffset.x > scrollView.contentOffset.x) {
         directionScrolled = .left
         print("Scrolled Left")
         BinaryTree.sharedInstance.currentNode = BinaryTree.sharedInstance.currentNode?.parent
         reloadViews(directionSwiped: .left)
         //         getScrollViewPage()
      }
      else if (lastContentOffset.y < scrollView.contentOffset.y) {
         directionScrolled = .down
         print("Scrolled Down")
         BinaryTree.sharedInstance.currentNode = BinaryTree.sharedInstance.currentNode?.leftChild
         reloadViews(directionSwiped: .down)
      }
      else if (lastContentOffset.y > scrollView.contentOffset.y) {
         directionScrolled = .up
         print("Scrolled Up")
         BinaryTree.sharedInstance.currentNode = BinaryTree.sharedInstance.currentNode?.parent
         reloadViews(directionSwiped: .up)
      }
      else {
         print("none of these happened")
      }
      
   }
   
   
   
   
   // Used to load the Scroll view on the initial load
   
   func firstLoad() {
      
      guard let rootNode = BinaryTree.sharedInstance.rootNode else {return}
      
      let rightChildNodes = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 1, myCurrentNode: rootNode)
      let leftChildNodes = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 0, myCurrentNode: rootNode)
      
      scrollView.contentSize = CGSize(width: view.frame.width + view.frame.width * CGFloat(rightChildNodes.count), height: view.frame.height + view.frame.height * CGFloat(leftChildNodes.count))
      
      let rootView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
      rootView.backgroundColor = UIColor.yellow
      contentView.addSubview(rootView)

//      scrollView.bringSubview(toFront: rootView)
      
      if leftChildNodes.count > 0 {
         for node in 1...leftChildNodes.count {
            let newView = UIView(frame: CGRect(x: 0, y: view.frame.height * CGFloat(node), width: view.frame.width, height: view.frame.height))
            newView.backgroundColor = UIColor.random()
            
            let label = UILabel(frame: CGRect(x: 16, y: self.view.frame.midY, width: self.view.frame.width, height: 24))
            let nodeValue = String(leftChildNodes[node - 1].value)
            print(nodeValue)
            label.text = nodeValue
            newView.addSubview(label)
            contentView.addSubview(newView)
         }
      }
      if rightChildNodes.count > 0 {
         for node in 1...rightChildNodes.count {
            //            rightChildNodes[node].value
            //            () = {
            //               //shopwithid(rightChildNodes[node].value)
            //            }
            let newView = UIView(frame: CGRect(x: view.frame.width * CGFloat(node), y: 0, width: view.frame.width, height: view.frame.height))
            newView.backgroundColor = UIColor.random()
            contentView.addSubview(newView)
         }
      }
      
   }
   
   
   // Used to reload the scroll view when new screen is scrolled to. Reloaded view will reload all children to current node.
   
   func reloadViews(directionSwiped: ScrollDirection) {
      
      guard let currentNode = BinaryTree.sharedInstance.currentNode else {return}
      print("Current Node is: \(currentNode.value)")
      
      moveUp(currentNode: currentNode)
      
      let rightChildNodes = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 1, myCurrentNode: currentNode)
      let leftChildNodes = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 0, myCurrentNode: currentNode)
      
      switch directionSwiped {
         
      case .left, .right:
         
         scrollView.contentSize.height = view.frame.height + view.frame.height * CGFloat(leftChildNodes.count)
         
         if rightChildNodes.count > 0 {
            for node in 1...rightChildNodes.count {
               
               let newView = UIView(frame: CGRect(x: view.frame.width * CGFloat(node), y: 0, width: view.frame.width, height: view.frame.height))
               newView.backgroundColor = UIColor.random()
               let label = UILabel(frame: CGRect(x: 16, y: self.view.frame.midY, width: self.view.frame.width, height: 24))
               let nodeValue = String(leftChildNodes[node - 1].value)
               print(nodeValue)
               label.text = nodeValue
               newView.addSubview(label)
               contentView.addSubview(newView)
            }
         }
         
      case .up, .down:
         
         scrollView.contentSize.width = view.frame.width + view.frame.width * CGFloat(rightChildNodes.count)
         
         if leftChildNodes.count > 0 {
            for node in 1...leftChildNodes.count {
               let newView = UIView(frame: CGRect(x: 0, y: view.frame.height * CGFloat(node), width: view.frame.width, height: view.frame.height))
               newView.backgroundColor = UIColor.random()
               
               let label = UILabel(frame: CGRect(x: 16, y: self.view.frame.midY, width: self.view.frame.width, height: 24))
               let nodeValue = String(leftChildNodes[node - 1].value)
               print(nodeValue)
               label.text = nodeValue
               newView.addSubview(label)
               contentView.addSubview(newView)
            }
         }
         
      default:
         break
      }
   }
   
   
   // Return a vector which will have an (x,y) -> x will be rows and y will be columns
   func getScrollViewPage() -> CGPoint {
      
      let width = scrollView.frame.size.width
      let height = scrollView.frame.size.height
      let pagesInRow = scrollView.contentSize.width / width
      let pagesInColumn = scrollView.contentSize.height / height
      
      let currentPageInRow = scrollView.contentOffset.x / width
      let currentPageInColumn = scrollView.contentOffset.x / height
      
      let currentPage = CGPoint(x: currentPageInRow, y: currentPageInColumn)
      
      return (currentPage)
   }
   
   
   
   func isPageBeforeLast() -> Bool {
      
      var width = scrollView.frame.size.width
      var totalPages = scrollView.contentSize.width / width
      
      var page = scrollView.contentOffset.x / width
      
      if page == 1 {
         return true
      } else if page == totalPages - 1 {
         return true
      }
      return false
   }
   
   
   
   func drawViews(currentNode: Node?) {
      
      guard let currentNode = currentNode else {return}
      print("Current Node is: \(currentNode.value)")
      
      let rightChildNodes = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 1, myCurrentNode: currentNode)
      let leftChildNodes = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 0, myCurrentNode: currentNode)
      
      
      if leftChildNodes.count > 0 {
         for node in 1...leftChildNodes.count {
            let newView = UIView(frame: CGRect(x: 0, y: view.frame.height * CGFloat(node), width: view.frame.width, height: view.frame.height))
            newView.backgroundColor = UIColor.random()
            
            let label = UILabel(frame: CGRect(x: 16, y: self.view.frame.midY, width: self.view.frame.width, height: 24))
            let nodeValue = String(leftChildNodes[node - 1].value)
            print(nodeValue)
            label.text = nodeValue
            newView.addSubview(label)
            contentView.addSubview(newView)
         }
      }
      if rightChildNodes.count > 0 {
         for node in 1...rightChildNodes.count {
            //            rightChildNodes[node].value
            //            () = {
            //               //shopwithid(rightChildNodes[node].value)
            //            }
            let newView = UIView(frame: CGRect(x: view.frame.width * CGFloat(node), y: 0, width: view.frame.width, height: view.frame.height))
            newView.backgroundColor = UIColor.random()
            contentView.addSubview(newView)
         }
      }
   }
   
   
   
   func moveUp(currentNode: Node) -> [Node] {
      
      var nodeArray = [Node]()
      guard let parent = currentNode.parent else {return nodeArray}
      
      if currentNode.parent?.rightChild?.value != currentNode.value {
         let rightChildNodes = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 1, myCurrentNode: currentNode)
         for node in rightChildNodes {
            nodeArray.append(node)
         }
         return nodeArray
      } else {
         return moveUp(currentNode: parent)
      }
   }
   
   
   
   
   
   /*
    
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
    
    */
   
   
}
