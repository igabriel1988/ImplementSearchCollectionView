//
//  ViewController.swift
//  ImplementSearchCollectionView
//
//  Created by Ivan Gabriel on 23/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    var birdList = [BirdsData]()
    
    //buscar1
        var searching = false
        var searchedBirds = [BirdsData]()
        let searchController = UISearchController(searchResultsController: nil)
    
    
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        configureSearchController()
        
    }

    //buscar2
    private func configureSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Busca por Nombre de Pajaro"
        
        
    }
    
    
    private func fillData(){
        let bird1  = BirdsData(bName: "Baja California", bImage: "baja_california")
        birdList.append(bird1)
    }
}

//buscar3
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UISearchResultsUpdating,UISearchBarDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching{
            return searchedBirds.count
        }else{
            return birdList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
        
        if searching{
            cell.myImage.image = UIImage(named: searchedBirds[indexPath.row].birdImage)
            cell.myLabel.text = searchedBirds[indexPath.row].birdName
        }else{
            cell.myImage.image = UIImage(named: birdList[indexPath.row].birdImage)
            cell.myLabel.text = birdList[indexPath.row].birdName
        }
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2
        
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty{
            searching = true
            searchedBirds.removeAll()
            
            for bird in birdList{
                if bird.birdName.lowercased().contains(searchText.lowercased()){
                    searchedBirds.append(bird)
                }
            }
            
        }else{
            searching = false
            searchedBirds.removeAll()
            searchedBirds = birdList
        }
        
        myCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searching = false
            searchedBirds.removeAll()
            myCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searching{
            print("Diste clic pajaro1")
        }else{
            print("Clic en el pajaro else")
        }
    }
    
}
