//
//  ViewController.swift
//  YouDeserveIt
//
//  Created by eyal avisar on 22/01/2021.

import UIKit

class ViewController: UIViewController {

    var treats:[[String:Any]] = []
    let reachability = try! Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTreatsData()
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

    func getTreatsData() {
        //add random event for success/failure due internet connection
        //think about first time where nothing is cached
        if let url = URL(string: "https://restcountries.eu/rest/v2/all?fields=name;nativeName;area;borders;alpha3Code") {
           URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
//                      do {
//                        let json = try? (JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]])
//                      }
                self.treats = json["DataObject"]!["DataListObject"]!
                print(self.treats)
                   }
               }.resume()
        }
        

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


