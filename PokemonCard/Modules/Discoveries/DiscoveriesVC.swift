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
    
    var cardCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearance()
        view.backgroundColor = Color.background
        
        setupNavigationBar()
        collectionViewSetup()
        cardCollectionView?.dataSource = self
        cardCollectionView?.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func collectionViewSetup() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 100, right: 16)
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.24,
                                 height: UIScreen.main.bounds.width / 1.5)
        
        layout.minimumLineSpacing = 8
        
        layout.minimumInteritemSpacing = 8
        
        cardCollectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: UIScreen.main.bounds.width,
                                                            height: UIScreen.main.bounds.height),
                                              collectionViewLayout: layout)
        
        self.view.addSubview(cardCollectionView!)
        
        cardCollectionView?.register(DiscoveriesCell.self, forCellWithReuseIdentifier: "DiscoveriesCell")
        cardCollectionView?.backgroundColor = UIColor.clear
        
        cardCollectionView?.snp.makeConstraints { make in
            make.top.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
}

extension DiscoveriesVC: DiscoveriesPresenterToViewProtocol {
    
}

extension DiscoveriesVC: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
    }
}

extension DiscoveriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoveriesCell", for: indexPath) as? DiscoveriesCell {
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
