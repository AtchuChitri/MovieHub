//
//  WebServiceContract+AlamofireImage.swift
//  MovieHub
//
//  Created by Atchu on 6/2/23.
//

import Foundation
import Alamofire
import AlamofireImage
import Combine

typealias ImgDownloaderFuture = Future<Data, Never>

extension WebServiceContract {
    
    func getImageFromURL(url: String) -> ImgDownloaderFuture {
        return Future { promise in
            let imgUrl = "https://image.tmdb.org/t/p/original\(url)"
            AF.request(imgUrl).responseImage { response in
                if case .success(let image) = response.result, let jpgData = image.jpegData(compressionQuality: 0.9) {
                    promise(.success(jpgData))
                }
            }
        }
        
    }
}
