//
//  ImageLoader.swift
//  HQPlay
//
//  Created by Henrique Lima on 31/03/21.
//  Copyright © 2021 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

class ImageLoader: UIImageView {

    var activity: UIActivityIndicatorView = UIActivityIndicatorView()
    private let connector: ConnectorRequestProtocol = ConnectorRequest.shared
    private let endPoint = "comics"
    
    func setupActivity() {
        addSubview(activity)
        activity.transform = CGAffineTransform(scaleX: 1.5, y: 1.5);
        activity.startAnimating()
        activity.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            activity.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activity.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activity.heightAnchor.constraint(equalToConstant: 50),
            activity.widthAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.image = image
        }
    }
    
    func restart() {
        self.image = nil
        activity.startAnimating()
    }
    
    func loadImage(url: String) {
                
        connector.downloadHqCover(url: url) { (responseData) in
            
            switch responseData {
                case .Success(let imageData, _):
                    if let data = imageData, let image = UIImage.init(data: data) {
                        self.setImage(image)
                    }
                case .Error(_ , _):
                    print("erro na api")
            }
            
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupActivity()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupActivity()
    }

}
