//
//  CustomCollectionViewCell.swift
//  OscarPinterest
//
//  Created by Oscar Edward on 28/06/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func downloadImage(urlString: String){
        guard let url = URL(string: urlString)else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imgView.image = image
            }
        }
        task.resume()
    }

}
