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
      
      navigationController?.isNavigationBarHidden = true
      scrollView.delegate = self
      scrollView.isPagingEnabled = true
      scrollView.bounces = false
      scrollView.isDirectionalLockEnabled = true
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      
      self.automaticallyAdjustsScrollViewInsets = false;
//      scrollView.contentInset = UIEdgeInsets.zero
//      scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
//      scrollView.contentOffset = CGPoint(x: 0, y: 0)
      
      
      firstLoad()
      
   }
   
   
   
   func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
      lastContentOffset = scrollView.contentOffset
   }
   
   func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      
      if (lastContentOffset.x < scrollView.contentOffset.x) {
         directionScrolled = .right
         print("Scrolled Right")
         BinaryTree.sharedInstance.currentNode = BinaryTree.sharedInstance.currentNode?.rightChild
         reloadViews(directionSwiped: .right)
      }
      else if (lastContentOffset.x > scrollView.contentOffset.x) {
         directionScrolled = .left
         print("Scrolled Left")
         BinaryTree.sharedInstance.currentNode = BinaryTree.sharedInstance.currentNode?.parent
         reloadViews(directionSwiped: .left)
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
   
   
   
   //   func scrollViewDidScroll(_ scrollView: UIScrollView) {
   //
   //      switch directionScrolled {
   //      case .left:
   //         BinaryTree.sharedInstance.currentNode = BinaryTree.sharedInstance.currentNode?.parent
   //         loadViews()
   //      case .right:
   //         BinaryTree.sharedInstance.currentNode = BinaryTree.sharedInstance.currentNode?.rightChild
   //         loadViews()
   //      case .down:
   //         BinaryTree.sharedInstance.currentNode = BinaryTree.sharedInstance.currentNode?.leftChild
   //         loadViews()
   //      case .up:
   //         BinaryTree.sharedInstance.currentNode = BinaryTree.sharedInstance.currentNode?.parent
   //         loadViews()
   //      default:
   //         break
   //      }
   //   }
   
   
   
   // Used to load the Scroll view on the initial load
   
   func firstLoad() {
      
      guard let rootNode = BinaryTree.sharedInstance.rootNode else {return}
      
      print("Current Node is: \(BinaryTree.sharedInstance.currentNode?.value)")
      
      let rightChildNodes = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 1, myCurrentNode: rootNode)
      let leftChildNodes = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 0, myCurrentNode: rootNode)
      
      scrollView.contentSize = CGSize(width: view.frame.width + view.frame.width * CGFloat(rightChildNodes.count), height: view.frame.height + view.frame.height * CGFloat(leftChildNodes.count))
      
      scrollView.bringSubview(toFront: contentView)
      
      for node in 1...rightChildNodes.count {
         let newView = UIView(frame: CGRect(x: view.frame.width * CGFloat(node), y: 0, width: view.frame.width, height: view.frame.height))
         newView.backgroundColor = UIColor.random()
         contentView.addSubview(newView)
      }
      
      for node in 1...leftChildNodes.count {
         let newView = UIView(frame: CGRect(x: 0, y: view.frame.height * CGFloat(node), width: view.frame.width, height: view.frame.height))
         newView.backgroundColor = UIColor.random()
         contentView.addSubview(newView)
      }
      
      
   }
   
   
   // Used to reload the scroll view when new screen is scrolled to. Reloaded view will reload all children to current node.
   
   func reloadViews(directionSwiped: ScrollDirection) {
      
      guard let currentNode = BinaryTree.sharedInstance.currentNode else {return}
      print("Current Node is: \(currentNode.value)")
      
      let rootRightChildren = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 1, myCurrentNode: BinaryTree.sharedInstance.rootNode!)
      let rootLeftChildren = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 0, myCurrentNode: BinaryTree.sharedInstance.rootNode!)
      
      let rightChildNodes = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 1, myCurrentNode: currentNode)
      let leftChildNodes = BinaryTree.sharedInstance.getArrayOfChildNodes(direction: 0, myCurrentNode: currentNode)
      
      switch directionSwiped {
      case .left, .right:
         
         print("left child node count is \(leftChildNodes.count)")
         print("right child node count is \(rightChildNodes.count)")
         
         scrollView.contentSize.height = view.frame.height + view.frame.height * CGFloat(leftChildNodes.count)
         
         
         if leftChildNodes.count > 0 {
            for node in 1...leftChildNodes.count {
               let newView = UIView(frame: CGRect(x: 0, y: view.frame.height * CGFloat(node), width: view.frame.width, height: view.frame.height))
               newView.backgroundColor = UIColor.random()
               //            print("leftChild node is \(node)")
               contentView.addSubview(newView)
            }
         }
         if rightChildNodes.count > 0 {
            for node in 1...rightChildNodes.count {
               let newView = UIView(frame: CGRect(x: view.frame.width * CGFloat(node), y: 0, width: view.frame.width, height: view.frame.height))
               newView.backgroundColor = UIColor.random()
               //            print("rightChild node is \(node)")
               contentView.addSubview(newView)
            }
         }
         
      case .up, .down:
         
         print("left child node count is \(leftChildNodes.count)")
         print("right child node count is \(rightChildNodes.count)")
         
         scrollView.contentSize.width = view.frame.width + view.frame.width * CGFloat(rightChildNodes.count)
         
         if leftChildNodes.count > 0 {
            for node in 1...leftChildNodes.count {
               let newView = UIView(frame: CGRect(x: 0, y: view.frame.height * CGFloat(node), width: view.frame.width, height: view.frame.height))
               newView.backgroundColor = UIColor.random()
               contentView.addSubview(newView)
            }
         }
         if rightChildNodes.count > 0 {
            for node in 1...rightChildNodes.count {
               let newView = UIView(frame: CGRect(x: view.frame.width * CGFloat(node), y: 0, width: view.frame.width, height: view.frame.height))
               newView.backgroundColor = UIColor.random()
               contentView.addSubview(newView)
            }
         }
      default:
         break
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
