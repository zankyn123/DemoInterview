//
//  MainCollectionViewCell.swift
//  ProjectDemo
//
//  Created by Manh Hung on 27/10/24.
//

import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setEntity(_ entity: MainViewControllerEntity) {
        mainImageView.kf.setImage(with: entity.largeImageUrl)
    }
}
