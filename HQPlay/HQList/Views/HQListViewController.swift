//
//  HQListViewController.swift
//  HQPlay
//
//  Created by Henrique Pereira de Lima on 04/12/18.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

class HQListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView : UICollectionView!
    let viewModel = HQListViewModel()
    var listHQ : [HQ] = [] {
        didSet{
            self.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.fetchHQList { (listHqResponse) in
            
            switch listHqResponse{
            case .Success(let hqs, let statusCode):
                    self.listHQ = hqs!
                
            case .Error(let texto, let status):
                    debugPrint(texto)
            
            }
        }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listHQ.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HQCoverCellCollectionViewCell", for: indexPath ) as! HQCoverCellCollectionViewCell
        var hq  = self.listHQ[indexPath.row]
        cell.setData(hq)
        if hq.image == nil {
            self.viewModel.downloadCover(url: hq.thumbnail.fullPath) { (resultImage) in
                
                switch resultImage {
                case .Success(let dataOptional):
                    if let data = dataOptional {
                            if let image = UIImage.init(data: data){
                                DispatchQueue.main.async {
                                    hq.image = data
                                    cell.setImage(image: image)
                                }
                            }
                    }
                    return
                case .Error():
                    debugPrint("erro ao carregar imagem")
                }
                
            }
        } else {
            if let data = hq.image ,let image = UIImage.init(data: data){
                cell.setImage(image: image)
            }
        }
        
        
        return cell

    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch kind {
//
//        case UICollectionElementKindSectionHeader:
//
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "characterListHeader", for: indexPath) as! CharacterListHeader
//            header.rectangleView.backgroundColor = .comicYellow
//            header.rectangleView.setBlackBorder()
//            return header
//
//        case UICollectionElementKindSectionFooter:
//            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "characterListFooter", for: indexPath)
//            return footer
//
//        default:
//            assert(false, "Unexpected element kind")
//        }
//    }
    
    
    
    // MARK - COLLECTION VIEW DELEGATE
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if !_isFirstLoading {
//            if let character = characterViewModel?.characterList[indexPath.row] {
//                characterViewModel?.currentCharacter = character
//                self.performSegue(withIdentifier: "segueToCharacter", sender: self)
//            }
//        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
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
