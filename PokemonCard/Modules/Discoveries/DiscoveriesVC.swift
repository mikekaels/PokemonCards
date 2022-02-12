//
//  DiscoveriesVC.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 08/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import SkeletonView

class DiscoveriesVC: UIViewController {
    
    var presentor: DiscoveriesViewToPresenterProtocol?
    public var delegate: DiscoveriesDelegate?
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Find Pokemon"
        sc.searchBar.delegate = self
        sc.searchBar.searchTextField.textColor = UIColor.white
        return sc
    }()
    
    private var cardCollectionView: UICollectionView?
    
    var noConnectionView: NoDataView = NoDataView()
    
    var spinerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.isHidden = true
        return spinner
    }()
    
    
    
    //MARK: - PROPERTIES
    var cards: [Card] = [Card]()
    var page: Int = 1
    var pageSize: Int = 10
    var totalPage: Int = 100
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
        navigationBarAppearance()
        setupNavigationBar()
        collectionViewSetup()
        
        cardCollectionView?.dataSource = self
        cardCollectionView?.delegate = self
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cardCollectionView?.isSkeletonable = true
        if cards.isEmpty { startSkeleton() }
    }
    
    func startSkeleton() {
        cardCollectionView?.isUserInteractionDisabledWhenSkeletonIsActive = true
        let gradient = SkeletonGradient(baseColor: Color.yelloWPokemon)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        cardCollectionView?.showAnimatedGradientSkeleton(usingGradient: gradient, animation:animation, transition: .crossDissolve(0.25))
    }
    
    func fetchData() {
        presentor?.fetchCards(page: page, pageSize: pageSize)
    }
}



//MARK: - PRESENTER DELEGATE
extension DiscoveriesVC: DiscoveriesPresenterToViewProtocol {
    func didFetchCards(cards: Cards) {
        if cards.data.count != 0 {
            self.noConnectionView.removeFromSuperview()
            self.cards.append(contentsOf: cards.data)
            
            DispatchQueue.main.async { [weak self] in
                self?.cardCollectionView?.performBatchUpdates({
                    self?.cardCollectionView?.reloadSections(NSIndexSet(index: 0) as IndexSet)
                    
                }, completion: { finished in
                    self?.cardCollectionView?.stopSkeletonAnimation()
                    self?.cardCollectionView?.hideSkeleton()
                })
            }
        } else if self.cards.count == 0 && self.searchText != nil && cards.data.count == 0 {
                self.noConnectionView.label.text = "No such card with the name '\(String(describing: self.searchText!))', \n try another name"
                self.view.addSubview(self.noConnectionView)
                self.noConnectionView.snp.makeConstraints { make in
                    make.top.equalTo(self.view)
                    make.right.equalTo(self.view)
                    make.left.equalTo(self.view)
                    make.bottom.equalTo(self.view)
                }
        }
    }
    
    func didErrorFetchCards(error: CustomError) {
        if error == .noInternetConnection {
            self.noInternetConnection(true) { [weak self] in
                self?.fetchData()
            }
        }
    }
}

//MARK: - UISEARCHBAR DELEGATE
extension DiscoveriesVC: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        scrollToTop()
        self.searchText = searchBar.text
        presentor?.findCards(name: searchBar.text!, page: page, pageSize: pageSize)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("👉 ", self.cards.count )
        if searchText != nil && self.cards.count == 0 {
            self.searchText = nil
            scrollToTop()
            presentor?.fetchCards(page: page, pageSize: pageSize)
        }
    }
    
    func scrollToTop() {
        self.page = 1
        self.cards.removeAll()
        self.cardCollectionView?.reloadData()
        
        let topOffest = CGPoint(x: 0, y: (self.cardCollectionView?.contentInset.top ?? 0))
        self.cardCollectionView?.setContentOffset(topOffest, animated: true)
    }
}

//MARK: - INFINITE SCROLLING
extension DiscoveriesVC {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if page < totalPage && indexPath.row == cards.count - 1 {
            self.spinner.isHidden = false
            self.page += 1
            
            if let text = self.searchText {
                self.presentor?.findCards(name: text, page: self.page, pageSize: self.pageSize)
            } else {
                self.presentor?.fetchCards( page: self.page, pageSize: self.pageSize)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.spinner.isHidden = true
            }
        }
    }
}

//MARK: - UICOLLECTION DELEGATE
extension DiscoveriesVC: UICollectionViewDelegate, UICollectionViewDataSource, SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return Identifier.discoveriesCell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.discoveriesCell, for: indexPath) as? DiscoveriesCell {
            let card = cards[indexPath.row]
            cell.setupCell(image: card.images?.small ?? "")
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = cards[indexPath.row].id
        presentor?.goToCardDetail(id: id, from: self)
    }
}

//MARK: - UI SETUP (NAVBAR, COLLECTION VIEW)
extension DiscoveriesVC {
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func collectionViewSetup() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 100, right: 0)
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.238,
                                 height: UIScreen.main.bounds.width / 1.65)
        
        layout.minimumLineSpacing = 8
        
        layout.minimumInteritemSpacing = 8
        
        cardCollectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: UIScreen.main.bounds.width,
                                                            height: UIScreen.main.bounds.height),
                                              collectionViewLayout: layout)
        
        self.view.addSubview(cardCollectionView!)
        
        cardCollectionView?.register(DiscoveriesCell.self, forCellWithReuseIdentifier: Identifier.discoveriesCell)
        cardCollectionView?.backgroundColor = Color.background
        cardCollectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cardCollectionView?.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(self.view)
        }
        
        view.addSubview(spinerView)
        spinerView.topAnchor.constraint(equalTo: cardCollectionView!.bottomAnchor, constant: -UIScreen.main.bounds.height/5).isActive = true
        spinerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        spinerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/5).isActive = true
        
        spinerView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: spinerView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: spinerView.centerYAnchor).isActive = true
    }
}


