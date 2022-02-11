//
//  DiscoveriesCell.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 08/02/22.
//

import UIKit
import SnapKit
import Kingfisher
import SkeletonView

class DiscoveriesCell: UICollectionViewCell {
    
    var image: UIImageView = UIImageView()
        .configure { v in
            v.isSkeletonable = true
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
        self.layer.masksToBounds = true
        addViews()
    }
    
    func addViews() {
        self.layer.cornerRadius = 3
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

extension DiscoveriesCell {
    func setupCell(image: String) {
        startSkeleton()
        self.image.kf.indicatorType = .activity
        self.image.kf.setImage(with: URL(string: image)) { [weak self] result in
            self?.contentView.stopSkeletonAnimation()
            self?.contentView.hideSkeleton(transition: .crossDissolve(0.25))
        }
    }
    
    func startSkeleton() {
        let gradient = SkeletonGradient(baseColor: Color.yelloWPokemon)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        contentView.showAnimatedGradientSkeleton(usingGradient: gradient, animation:animation, transition: .crossDissolve(0.25))
    }
}
