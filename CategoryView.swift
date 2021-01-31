//
//  CategoryView.swift
//  Attractions
//
//  Created by eyal avisar on 28/01/2021.
//

import UIKit

class CategoryView: UIViewController {
    
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryId: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    var item = (0, 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryName.text = attractionsByCategories[item.0][item.1]["Title"] as! String
        categoryId.text = String(attractionsByCategories[item.0][item.1]["CatId"] as! Int)
        categoryImage?.image = UIImage(named: "happy")
    }
}
