//
//  ViewController.swift
//  YouDeserveIt
//
//  Created by eyal avisar on 22/01/2021.

import UIKit

extension CategoriesController: CategoryTableCellDelegate {
    func didSelectItem(categoryItem:(category:Int, row:Int))
 {
        let categoryView = storyboard?.instantiateViewController(identifier: "CategoryView") as! CategoryView
        
        categoryView.item = categoryItem
        self.navigationController?.pushViewController(categoryView, animated: true)
    }
}

class CategoriesController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var categoriesTable: UITableView!
    
    let reachability = try! Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTable.dataSource = self
        categoriesTable.delegate = self
        print(self.title)
        getAttractionssData()
//        print(json["DataObject"]?["DataListObject"]!) //24 objects
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    func offerSetting(_ animated: Bool) {
        let alertController = UIAlertController (title: "Title", message: "Go to Settings?", preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func getAttractionssData() {
        //add random event for success/failure due internet connection
        //think about first time where nothing is cached
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let sessionDataTask = session.dataTask(with: (NSURL(string: "https://restcountries.eu/rest/v2/all?fields=name;nativeName;area;borders;alpha3Code")) as! URL) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            attractions = json["DataObject"]!["DataListObject"]!
            
            categories = json["DataObject"]!["DataListCat"]!
            populateModels()
            self.populateTable()
        }
        
        sessionDataTask.resume()
    }

    func populateTable() {
        DispatchQueue.main.sync {
               self.categoriesTable.reloadData()
        }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
//        return categories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
//        return attractionsByCategories.count
//        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableCell
                

        cell.categoryName.text =
        categories[indexPath.row]["CTitle"] as! String
        cell.categoryId =
        categories[indexPath.row]["CatId"] as! Int
        cell.viewTitle = title!
        print("setting id title",cell.categoryId, cell.viewTitle)
        cell.attractionDelegate = self
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300.0
    }
    
    
        
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability

        switch reachability.connection {
        case .wifi:
            print("Wifi Connection")
        case .cellular:
            print("Cellular Connection")
        case .unavailable:
            print("No Connection")
            offerSetting(true)
            
        case .none:
            print("No Connection")
        }
    }

}


