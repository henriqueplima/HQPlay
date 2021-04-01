//
//  HQCoverCellCollectionViewCell.swift
//  HQPlay
//
//  Created by Henrique Pereira de Lima on 04/12/18.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

class HQCoverCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCover: ImageLoader!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    func setData(_ hq: HQListViewModel) {
        cleanFields()
        self.lbTitle.text = hq.title
        self.lblDate.text = hq.publishDate()
        self.imageViewCover.loadImage(url: hq.fullPath)
        self.configBorder()
    }
    
    func configBorder() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3
    }
    
    func setImage(image:UIImage) {
        self.imageViewCover.image = image
    }
    
    func cleanFields() {
        self.lbTitle.text = ""
        self.lblDate.text = ""
        imageViewCover.restart()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cleanFields()
    }
}
