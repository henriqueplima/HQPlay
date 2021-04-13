//
//  HQListViewController.swift
//  HQPlay
//
//  Created by Henrique Pereira de Lima on 04/12/18.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

protocol BaseControllerProtocol: class {
    func genericError()
}

protocol HQListControllerProtocol: BaseControllerProtocol {
    func successHQList(list: [HQListViewModel])
}

extension BaseControllerProtocol where Self: UIViewController {
    func genericError() {
        LoadingView.shared.close()
    }
}

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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        hqBussiness.viewController = self
        hqBussiness.fetchHQList()
    }
}

extension HQListViewController: HQListControllerProtocol {

    func successHQList(list: [HQListViewModel]) {
        self.hqViewModelList = list
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
        return CGSize(width: 180, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 3, height: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
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
