//
//  CardDetailsVC.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 09/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import Kingfisher
import SkeletonView

class CardDetailsVC: UIViewController {
    var presentor: CardDetailsViewToPresenterProtocol?
    public var delegate: CardDetailsDelegate?
    
    //MARK: - PROPERTIES
    var otherCards: [Card] = [Card]()
    var id : String?
    var type: String = "Grass"
    var page: Int = 1
    var pageSize: Int = 7
    var imageString: String?
    private let spacing: Int = 30
    private var totalPage: Int = 50
    
    let backgroundView: UIView = UIView()
        .configure { v in
            v.backgroundColor = .black
            v.layer.opacity = 0.7
        }
    let preview = UIView()
    let previewImage = UIImageView()
    
    private var otherCardsData = [OtherCardsData]()
    private var otherCardsCollectionView: UICollectionView?
    private let scrollView: UIScrollView = UIScrollView()
        .configure { v in
            v.showsVerticalScrollIndicator = false
        }
    private let contentView: UIView = UIView()
    
    private let imageView: UIImageView = UIImageView()
        .configure { v in
            v.isSkeletonable = true
            v.isUserInteractionEnabled = true
        }
    
    private let detailsContainer: UIView = UIView()
        .configure { v in
            v.isSkeletonable = true
        }
    private let descContainer: UIView = UIView()
        .configure { v in
            v.isSkeletonable = true
        }
    private let otherContainer: UIView = UIView()
        .configure { v in
            v.isSkeletonable = true
        }
    
    private let lbl0CardName: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.boldSystemFont(ofSize: 20)
            v.textColor = .white
            v.text = "Detective Pikachu"
        }
    
    private let lbl0Flavor: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.boldSystemFont(ofSize: 20)
            v.textColor = .white
            v.text = "Flavor"
        }
    
    private let lbl0OtherCards: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.boldSystemFont(ofSize: 20)
            v.textColor = .white
            v.text = "Other Cards"
        }
    
    private let lbl1Type: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.systemFont(ofSize: 16)
            v.textColor = .white
            v.text = "Lightning (HP 90)"
        }
    
    private let lbl1Level: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.systemFont(ofSize: 16)
            v.textColor = .white
            v.text = "Pokemon Basic"
        }
    
    private let lbl1Desc: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.italicSystemFont(ofSize: 16)
            v.textColor = .white
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.text = "He loves to show off his vast knowledge, this expressive Pikachu is like a middle-aged man. He loves to show off his vast knowledge"
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.showAnimatedSkeleton()
        self.view.backgroundColor = Color.background
        self.setupView()
        self.fetchCard(id: self.id ?? "xy1-1")
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(zoomIn))
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(gesture)
    }
    
    func fetchCard(id: String) {
        presentor?.fetchCardDetails(id: id)
    }
    
}



extension CardDetailsVC: CardDetailsPresenterToViewProtocol {
    func didGetOtherCards(cards: Cards) {
        self.otherCards.append(contentsOf: cards.data)
        
        DispatchQueue.main.async { [weak self] in
            self?.otherCardsCollectionView?.reloadData()
        }
    }
    
    func didErrorGetOtherCards(error: CustomError) {
        
    }
    
    func didFetchCardDetails(card: Card) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.kf.indicatorType = .activity
            self?.imageString = card.images!.small
            self?.imageView.kf.setImage(with: URL(string: card.images!.small))
            self?.lbl0CardName.text = card.name
            let types = card.types.joined(separator: ", ")
            self?.lbl1Type.text = "\(types) (HP \(card.hp))"
            let subtype = card.subtypes.joined(separator: ", ")
            self?.lbl1Level.text = "\(card.supertype) \(subtype)"
            self?.lbl1Desc.text = card.flavorText
            self?.lbl0Flavor.text = card.flavorText != nil ? "Flavor" : ""
            self?.type = card.types[0]
            self?.presentor?.getOtherCards(id: self!.id!, type: self!.type, page: self!.page, pageSize: self!.pageSize)
        }
    }
    
    func didErrorFetchCardDetails(error: CustomError) {

    }
    
    
}

//MARK: - INFINITE SCROLLING
extension CardDetailsVC {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if page < totalPage && indexPath.row == otherCards.count - 1 {
            self.page += 1
            
            self.presentor?.getOtherCards(id: self.id!, type: self.type, page: self.page, pageSize: self.pageSize)

        }
    }
}



//MARK: - UICOLLECTION
extension CardDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return otherCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.otherCardsCell, for: indexPath) as? OtherCardsCollectionViewCell else { return UICollectionViewCell()}
        let imageUrl = otherCards[indexPath.row]
        cell.setupCell(imageUrl: imageUrl.images!.small)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = otherCards[indexPath.row].id
        presentor?.goToNextCard(id: id, from: self)
    }
}


extension CardDetailsVC {
    public func collectionViewSetup() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 15)
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.20,
                                 height: UIScreen.main.bounds.width / 1.60)
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        otherCardsCollectionView = UICollectionView(frame: CGRect(x: 0,
                                                                  y: 0,
                                                                  width: UIScreen.main.bounds.width,
                                                                  height: UIScreen.main.bounds.height),
                                                    collectionViewLayout: layout)
        
        otherContainer.addSubview(otherCardsCollectionView!)
        otherCardsCollectionView?.delegate = self
        otherCardsCollectionView?.dataSource = self
        
        otherCardsCollectionView?.register(OtherCardsCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.otherCardsCell)
        otherCardsCollectionView?.backgroundColor = UIColor.clear
        
        otherCardsCollectionView?.snp.makeConstraints { make in
            make.top.equalTo(lbl0OtherCards.snp_bottomMargin).offset(20)
            make.left.equalTo(otherContainer).offset(-15)
            make.right.equalTo(otherContainer).offset(15)
            make.bottom.equalTo(otherContainer)
        }
        otherCardsCollectionView!.reloadData()
    }
}

//MARK: - ZOOM IN AND ZOOM OUT IMAGE
extension CardDetailsVC {
    @objc func zoomIn() {
        if let startingFrame = imageView.superview?.convert(imageView.frame, to: nil) {
            previewImage.kf.setImage(with: URL(string: self.imageString!))
            self.imageView.isHidden = true
            
            self.preview.frame = startingFrame
            let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
            self.preview.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: self.view.frame.width / 1.3, height: height / 1.3)
            self.preview.center = self.view.center
            
            backgroundView.frame = self.view.frame
            
            self.navigationController?.view.addSubview(backgroundView)
            self.navigationController?.view.addSubview(preview)
            
            preview.addSubview(previewImage)
            previewImage.snp.makeConstraints { make in
                make.top.right.bottom.left.equalTo(preview)
            }
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(zoomOut))
            self.backgroundView.isUserInteractionEnabled = true
            backgroundView.addGestureRecognizer(gesture)
        }
    }
    
    @objc func zoomOut() {
        preview.removeFromSuperview()
        preview.removeFromSuperview()
        backgroundView.removeFromSuperview()
        self.imageView.isHidden = false
    }
}

//MARK: - SETUP VIEW
extension CardDetailsVC {
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(scrollView).inset(16)
            make.bottom.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(280)
            make.top.equalTo(contentView).offset(20)
            make.centerX.equalTo(contentView)
        }
        
        contentView.addSubview(detailsContainer.configure(completion: { v in
            v.addSubview(lbl0CardName)
            lbl0CardName.snp.makeConstraints { make in
                make.top.equalTo(v)
                make.right.equalTo(v)
                make.left.equalTo(v)
            }
            
            v.addSubview(lbl1Type)
            lbl1Type.snp.makeConstraints { make in
                make.top.equalTo(lbl0CardName.snp_bottomMargin).offset(10)
                make.right.equalTo(v)
                make.left.equalTo(v)
            }
            
            v.addSubview(lbl1Level)
            lbl1Level.snp.makeConstraints { make in
                make.top.equalTo(lbl1Type.snp_bottomMargin).offset(10)
                make.right.equalTo(v)
                make.left.equalTo(v)
            }
        }))
        
        detailsContainer.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(18)
            make.right.equalTo(contentView)
            make.left.equalTo(contentView)
        }
        
        contentView.addSubview(descContainer.configure(completion: { v in
            v.addSubview(lbl0Flavor)
            lbl0Flavor.snp.makeConstraints { make in
                make.top.equalTo(v)
                make.right.equalTo(v)
                make.left.equalTo(v)
            }
            
            v.addSubview(lbl1Desc)
            lbl1Desc.snp.makeConstraints { make in
                make.top.equalTo(lbl0Flavor.snp_bottomMargin).offset(10)
                make.right.equalTo(v)
                make.left.equalTo(v)
            }
        }))
        
        descContainer.snp.makeConstraints { make in
            make.top.equalTo(lbl1Level.snp_bottomMargin).offset(spacing)
            make.right.equalTo(contentView)
            make.left.equalTo(contentView)
        }
        
        contentView.addSubview(otherContainer.configure(completion: { v in
            v.addSubview(lbl0OtherCards)
            lbl0OtherCards.snp.makeConstraints { make in
                make.top.equalTo(v)
                make.right.equalTo(v)
                make.left.equalTo(v)
            }
        }))
        otherContainer.snp.makeConstraints { make in
            make.top.equalTo(lbl1Desc.snp_bottomMargin).offset(spacing)
            make.right.equalTo(contentView)
            make.left.equalTo(contentView)
            make.height.equalTo(300)
        }
        
        collectionViewSetup()
    }
}

