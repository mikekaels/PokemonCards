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
    
    var id : String?
    var imageString: String?
    
    private let spacing: Int = 30
    
    private var otherCardsData = [OtherCardsData]()
    
    private var otherCardsCollectionView: UICollectionView?
    
    private let scrollView: UIScrollView = UIScrollView()
    
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
    
    let backgroundView: UIView = UIView()
        .configure { v in
            v.backgroundColor = .black
            v.layer.opacity = 0.9
        }
    
    let preview = UIView()
    let previewImage = UIImageView()
    
    @objc func zoomIn() {
        if let startingFrame = imageView.superview?.convert(imageView.frame, to: nil) {
            
            let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
            
            preview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 1.3, height: height / 1.3)
            preview.center = self.view.center
            
            self.imageView.isHidden = true
            
            backgroundView.frame = self.view.frame
            self.navigationController?.view.addSubview(backgroundView)
            
            self.navigationController?.view.addSubview(preview)
            
            preview.addSubview(previewImage)
            
            previewImage.snp.makeConstraints { make in
                make.top.right.bottom.left.equalTo(preview)
            }
            
            previewImage.kf.setImage(with: URL(string: self.imageString!))
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(zoomOut))
            self.previewImage.isUserInteractionEnabled = true
            previewImage.addGestureRecognizer(gesture)
        }
    }
    
    @objc func zoomOut() {
        preview.removeFromSuperview()
        preview.removeFromSuperview()
        backgroundView.removeFromSuperview()
        self.imageView.isHidden = false
    }
}



extension CardDetailsVC: CardDetailsPresenterToViewProtocol {
    func didFetchCardDetails(card: Card) {
        print("👉 Card: ", card)
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
        }
    }
    
    func didErrorFetchCardDetails(error: CustomError) {
        print("🔥 Error: ",error)
    }
    
    
}


//MARK: - UICOLLECTION
extension CardDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return otherCardsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.otherCardsCell, for: indexPath) as? OtherCardsCollectionViewCell else { return UICollectionViewCell()}
        let imageUrl = otherCardsData[indexPath.row].image
        cell.setupCell(imageUrl: imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
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

        otherCardsData.append(OtherCardsData(image: "https://images.pokemontcg.io/smp/SM110.png"))
        otherCardsData.append(OtherCardsData(image: "https://images.pokemontcg.io/smp/SM110.png"))
        otherCardsData.append(OtherCardsData(image: "https://images.pokemontcg.io/smp/SM110.png"))
        otherCardsData.append(OtherCardsData(image: "https://images.pokemontcg.io/smp/SM110.png"))
        otherCardsData.append(OtherCardsData(image: "https://images.pokemontcg.io/smp/SM110.png"))
        otherCardsData.append(OtherCardsData(image: "https://images.pokemontcg.io/smp/SM110.png"))
        collectionViewSetup()
    }
}
