//
//  ImageViewController.swift
//  Ejercicio1
//
//  Created by DISMOV on 14/06/24.
//

import UIKit

class ImageViewController: UIViewController {
    
    var internetMonitor = InternetMonitor()
    
    //Variables for UI
    var imageView: UIImageView!
    var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        self.view.addSubview(imageView)
        
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.center = view.center
        activityIndicatorView.hidesWhenStopped = true
        self.view.addSubview(activityIndicatorView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if internetMonitor.isConnected {
            //Si hay conexión a Internet, descarga la imágen
            let urlString = "http://fundacionunam.org/cei/assets/img/unam.jpg"
            if let url = URL(string: urlString) {
                activityIndicatorView.startAnimating()
                
                let request = URLRequest(url: url)
                let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
                let task = session.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        
                        if (error == nil) {
                            //Todo bien, cargar la imágen
                            self.imageView.image = UIImage(data: data!)
                        } else {
                            //Todo mal, manejar el error
                            print ("Error: \(error!.localizedDescription)")
                        }
                    }
                }
                task.resume()
            }
        } else {
            imageView.image = UIImage(systemName: "wifi.exclamationmark")
        }
    }
    

}
