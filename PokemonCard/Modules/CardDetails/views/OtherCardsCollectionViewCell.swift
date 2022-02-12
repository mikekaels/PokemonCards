//
//  OtherCardsCollectionViewCell.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 09/02/22.
//

import UIKit
import Kingfisher

class OtherCardsCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()
        .configure { v in
            v.contentMode = .scaleAspectFill
            v.clipsToBounds = true
            let urls = URL(string: "https://images.pokemontcg.io/smp/SM110.png")
            v.kf.indicatorType = .activity
            v.kf.setImage(with: urls)
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.width.height.equalTo(contentView).inset(5)
        }
    }
    
    public func setupCell(imageUrl: String) {
        let urls = URL(string: imageUrl)
        imageView.kf.setImage(with: urls)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

class SpinnerCollectionCell: UICollectionViewCell {
    var imageView = UIImageView()
        .configure { v in
            v.contentMode = .scaleAspectFill
            v.clipsToBounds = true
            let urls = URL(string: "")
            v.kf.indicatorType = .activity
            v.kf.setImage(with: urls)
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.width.height.equalTo(contentView).inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}
