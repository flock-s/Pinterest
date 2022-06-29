//
//  APIResponse.swift
//  OscarPinterest
//
//  Created by Oscar Edward on 28/06/22.
//

import Foundation

struct APIResponseModel:Codable{
    let total:Int
    let total_pages:Int
    let results:[FetchedPictureListModel]
}

struct FetchedPictureListModel:Codable{
    let id:String
    let urls:PictureUrlList
}

struct PictureUrlList:Codable{
    let regular:String
}


