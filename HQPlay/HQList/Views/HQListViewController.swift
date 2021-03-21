//
//  HQListViewController.swift
//  HQPlay
//
//  Created by Henrique Pereira de Lima on 04/12/18.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

class HQListViewController: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    let hqBussiness = HQListBussiness()
    var hqViewModelList: [HQListViewModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.hqBussiness.fetchHQList { (listHqResponse) in
            
            switch listHqResponse{
                case .Success(let hqs):
                    self.hqViewModelList = hqs
                
                case .Error(let texto):
                    debugPrint(texto)
            }
        }
    }
}

// MARK: UICollectionViewDataSource

extension HQListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hqViewModelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HQCoverCellCollectionViewCell.self), for: indexPath ) as! HQCoverCellCollectionViewCell
        let hq = self.hqViewModelList[indexPath.row]
        cell.setData(hq)
//        if hq.image == nil {
//            self.hqBussiness.downloadCover(url: hq.thumbnail.fullPath) { (resultImage) in
//
//                switch resultImage {
//                case .Success(let dataOptional):
//                    if let data = dataOptional {
//                            if let image = UIImage.init(data: data){
//                                DispatchQueue.main.async {
//                                    hq.image = data
//                                    cell.setImage(image: image)
//                                }
//                            }
//                    }
//                    return
//                case .Error():
//                    debugPrint("erro ao carregar imagem")
//                }
//
//            }
//        } else {
//            if let data = hq.image ,let image = UIImage.init(data: data){
//                cell.setImage(image: image)
//            }
//        }
        
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if !_isFirstLoading {
//            if let character = characterViewModel?.characterList[indexPath.row] {
//                characterViewModel?.currentCharacter = character
//                self.performSegue(withIdentifier: "segueToCharacter", sender: self)
//            }
//        }
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension HQListViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = _isFirstLoading ? loadingCellSize : characterCellSize
        //return CGSize(width: size, height: size)
        return CGSize(width: 180, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: loadingCellSize, height: 32)
        return CGSize(width: 3, height: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: loadingCellSize, height: 10)
        return CGSize(width: 3, height: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    }
    
}
