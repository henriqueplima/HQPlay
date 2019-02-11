//
//  HQCoverCellCollectionViewCell.swift
//  HQPlay
//
//  Created by Henrique Pereira de Lima on 04/12/18.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

class HQCoverCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCover : UIImageView!
    @IBOutlet weak var lbTitle : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    
    
    func setData(_ hq:HQ) {
        
        self.lbTitle.text = hq.title
        self.lblDate.text = "publish \(hq.publishDate())"
        self.configBorder()
        
    }
    
    func configBorder(){
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3
    }
    
    func setImage(image:UIImage){
        self.imageViewCover.image = image
    }
    
}
