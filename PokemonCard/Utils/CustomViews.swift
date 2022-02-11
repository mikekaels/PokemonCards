//
//  CustomViews.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 12/02/22.
//

import UIKit
import SnapKit
import Kingfisher

class NoDataView: UIView {
    
    var image: UIImageView = UIImageView()
        .configure { v in
            v.image = UIImage(named: "pikachu_no_data")
            v.contentMode = .scaleAspectFill
        }
    
    var label: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.systemFont(ofSize: 16)
            v.textColor = .white
            v.text = ""
            v.numberOfLines = 0
            v.textAlignment = .center
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        self.addSubview(image)
        image.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(image.snp_bottomMargin).offset(20)
            make.left.right.equalTo(self).offset(15).inset(15)
            make.height.equalTo(100)
        }
        
        
    }
}
