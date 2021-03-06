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

extension UICollectionViewFlowLayout {

    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }

}

class CategoryTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryGallery: UICollectionView!
    
    var categoryId = 0
    var viewTitle = "nada"
    
    
    public weak var attractionDelegate: CategoryTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryGallery.delegate = self
        categoryGallery.dataSource = self
        

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if viewTitle == "favorites" {
            categoryGallery.isPagingEnabled = true
        }
        return attractionsByCategories[categoryId - 1].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionCell
        
        cell.isHidden = false
        
        cell.attractionImage.image = UIImage(named: "happy")
        
        cell.subtitleLabel.text = (attractionsByCategories[categoryId - 1][indexPath.row]["STitle"] as! String)
        
        
        cell.attractionImage.image = UIImage(named: "happy")

        if attractionsByCategories[categoryId - 1].count == indexPath.row {
            cell.isHidden = true
        }
        
        return cell
    }
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        if attractionsByCategories[categoryId - 1].count == indexPath.row {
            return
        }
        attractionDelegate?.didSelectItem(categoryItem: (categoryId - 1, indexPath.row))
    }
}
