//
//  CollectionViewController.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/19/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class CustomCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   
   var collectionView: UICollectionView!
   var allCells = [CustomCell]()
   var wasTapped = false
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
      layout.scrollDirection = UICollectionViewScrollDirection.horizontal
      layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
      layout.itemSize = CGSize(width: 90, height: 120)
      
      collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "Cell")
      collectionView.backgroundColor = UIColor.white
      self.view.addSubview(collectionView)
      
      
      let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
      collectionView.addGestureRecognizer(tap)
      
   }
   
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return allCells.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
      return cell
   }
   
   func handleTap(gestureRecognizer: UIGestureRecognizer) {
      print("tap confirmed")
//      if wasTapped == false {
//         
//         UIView.animate(withDuration: 1.0, animations: {
//            self.rootView.frame.size.width -= 125
//            self.rootView.frame.size.height -= 125
//            self.wasTapped = true
//         }, completion: nil)
//         
//         var newCell = CustomCell(frame: CGRect(x: 300, y: 200, width: 200, height: 200))
//         newCell.backgroundColor = .random()
//         collectionView.addSubview(newCell)
//         allCells.append(newCell)
//      }
      var newCell = CustomCell(frame: CGRect(x: 300, y: 200, width: 200, height: 200))
      newCell.backgroundColor = .random()
      collectionView.addSubview(newCell)
      allCells.append(newCell)
   }
}

class CustomCell: UICollectionViewCell {
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.backgroundColor = UIColor.green
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
}
