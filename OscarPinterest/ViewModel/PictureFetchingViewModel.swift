//
//  ViewModel.swift
//  OscarPinterest
//
//  Created by Oscar Edward on 28/06/22.
//

import Foundation

class PictureFetchingViewModel{
    private var baseUrl = "https://api.unsplash.com/search/photos?page=[page]&per_page=50&query=[keyword]&client_id=d8a272c480b258b875d82f4062d6c52e4ae7f4b4656add778d71e9b638b2f8be"
    var apiResponse:APIResponseModel?
    var pictureResults:FetchedPictureListModel?
    
    func getPhotosWithKeyword(keyword:String, page:Int, completion: @escaping() -> ()){
        baseUrl = baseUrl.replacingOccurrences(of: "[keyword]", with: keyword)
        baseUrl = baseUrl.replacingOccurrences(of: "[page]", with: String(page))
        guard let url = URL(string: baseUrl)else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(APIResponseModel.self, from: data)
                print("Success !")
                DispatchQueue.main.async {
                    self.apiResponse = result
                }
                completion()
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}
