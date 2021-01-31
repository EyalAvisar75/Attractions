//
//  CategoryTableCell.swift
//  Attractions
//
//  Created by eyal avisar on 26/01/2021.
//

import UIKit

protocol CategoryTableCellDelegate : AnyObject {
    func didSelectItem(categoryItem:(category:Int, row:Int))
}

class CategoryTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryGallery: UICollectionView!
    
    var categoryId = 0
    
    public weak var attractionDelegate: CategoryTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryGallery.delegate = self
        categoryGallery.dataSource = self
//        categoryGallery.tag = categoryId - 1
//        categoryGallery.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return attractionsByCategories[categoryId - 1].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionCell
        
        
        cell.attractionImage.image = UIImage(named: "happy")
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        print("row",indexPath.row)
//        print("section",indexPath.section)
//        print("item",indexPath.item)
//        print("category",categoryId)
//
//        print()
        attractionDelegate?.didSelectItem(categoryItem: (categoryId - 1, indexPath.row))
    }

    
}
