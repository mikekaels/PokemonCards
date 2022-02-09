//
//  DiscoveriesVC.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 08/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

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
        return sc
    }()
    
    private var cardCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
        navigationBarAppearance()
        setupNavigationBar()
        collectionViewSetup()
        
        cardCollectionView?.dataSource = self
        cardCollectionView?.delegate = self
    }
}

//MARK: - UI SETUP
extension DiscoveriesVC {
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func collectionViewSetup() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 30, right: 16)
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.24,
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
        cardCollectionView?.backgroundColor = UIColor.clear
        
        cardCollectionView?.snp.makeConstraints { make in
            make.top.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
}

//MARK: - PRESENTER
extension DiscoveriesVC: DiscoveriesPresenterToViewProtocol {
    
}

//MARK: - UISEARCHBAR DELEGATE
extension DiscoveriesVC: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
    }
}

//MARK: - UICOLLECTION DELEGATE
extension DiscoveriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.discoveriesCell, for: indexPath) as? DiscoveriesCell {
            cell.image.loadImageUsingUrlString(urlString: "https://images.pokemontcg.io/smp/SM110.png")
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        presentor?.goToCardDetail(from: self)
    }
}
