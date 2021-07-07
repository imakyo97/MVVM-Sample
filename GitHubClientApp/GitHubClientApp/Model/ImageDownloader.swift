//
//  ImageDownloader.swift
//  GitHubClientApp
//
//  Created by 今村京平 on 2021/07/06.
//

import UIKit

final class ImageDownloader {
    /*
     UIImageをキャッシュするための変数
     */
    var cacheImage: UIImage?

    func downloadImage(imageURL: String,
                       success: @escaping (UIImage) -> Void,
                       failure: @escaping (Error) -> Void) {
        /*
         もしキャッシュされたUIImageがあれば、それをClosureで返す。
         */
        if let cacheImage = cacheImage {
            success(cacheImage)
        }

        /*
         リクエストを作成
         */

        var request = URLRequest(url: URL(string: imageURL)!)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request)
            { (data, response, error) in
            /*
             Errorがあったら、ErrorをClosureで返す
             */
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }

            /*
             dataがなかったら、APIError.unknown ErrorをClosureで返す
             */
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                return
            }

            /*
             受け取ったデータからUIImageを生成できなければ、
             APIError.unknown ErrorをClosureで返す
             */
            guard let imageFromData = UIImage(data: data) else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                return
            }

            /*
             imageFromDataをClosureで返す
             */
            DispatchQueue.main.async {
                success(imageFromData)
            }

            /*
             画像をキャッシュする
             */
            self.cacheImage = imageFromData
        }

        task.resume()
        
    }

}
