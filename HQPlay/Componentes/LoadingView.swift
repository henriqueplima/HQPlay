//
//  loader.swift
//  teste
//
//  Created by Henrique Lima on 10/04/21.
//

import UIKit

class LoadingView: UIView {
    
    static let shared = LoadingView(frame: .zero)
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        let windowFrame = UIScreen.main.bounds
        super.init(frame: windowFrame)
        start()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        start()
    }
    
    private func  start() {
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        indicator.color = .white
        self.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 50),
            indicator.widthAnchor.constraint(equalToConstant: 50)
        ]
        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        NSLayoutConstraint.activate(constraints)
    }
    
    func show() {
        indicator.startAnimating()
        let window = UIApplication.shared.windows.first!
        window.addSubview(self)
        let constraint = [
            self.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            self.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            self.topAnchor.constraint(equalTo: window.topAnchor),
            self.bottomAnchor.constraint(equalTo: window.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraint)
    }
    
    func close() {
        removeFromSuperview()
        indicator.stopAnimating()
    }
}
