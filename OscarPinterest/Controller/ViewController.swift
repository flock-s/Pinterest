//
//  ViewController.swift
//  OscarPinterest
//
//  Created by Oscar Edward on 27/06/22.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    let dataModel = [1,2,3,4,5,6]
    let cellId = "customCell"
    let page = 1
    var viewModel = PictureFetchingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        self.searchbar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text{
            viewModel.getPhotosWithKeyword(keyword: text, page: page) {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }
    }
    
    func setupInitialView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
        if let layout = collectionView.collectionViewLayout as? CustomPinterestLayout {
            layout.delegate = self
        }
    }
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,CustomPinterestLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CustomCollectionViewCell {
            guard let imageUrl = self.viewModel.apiResponse?.results[indexPath.row].urls.regular else { return  UICollectionViewCell()}
            cell.downloadImage(urlString: imageUrl)
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 20
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.apiResponse?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath index: IndexPath) -> CGFloat {
        let cell = collectionView.cellForItem(at: index) as? CustomCollectionViewCell
        
        let image = cell?.imgView.image
        
        if let height = image?.size.height{
            return height
        }
        return 100.0
    }
}
