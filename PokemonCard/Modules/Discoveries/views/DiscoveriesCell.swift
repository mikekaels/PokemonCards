//
//  DiscoveriesCell.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 08/02/22.
//

import UIKit
import SnapKit

class DiscoveriesCell: UICollectionViewCell {
    
    var image: CustomImageView = CustomImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        addViews()
    }
    
    func addViews() {
        self.contentView.addSubview(image)

        self.image.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.height.equalTo(contentView.frame.height)
            make.width.equalTo(contentView.frame.width)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("🔥 Discoveries Cell deinitilized")
    }
}
