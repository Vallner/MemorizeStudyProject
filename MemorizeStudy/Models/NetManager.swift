//
//  NetManager.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 7.06.25.
//

import Foundation
import UIKit
enum CardType {
    case dog
    case cat
}
struct Dogs: Codable {
    let message: [String]
    let status: String
}
struct Cat: Codable {
    let id: String
    let url: String
    let width, height: Int
}


class NetManager {
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
   let urlSession = URLSession(configuration: .default)
   private func obtainDogsData() async throws -> Dogs{
        var url: URL = URL(string: "https://dog.ceo/api/breeds/image/random/8")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let responseData = try await urlSession.data(for: urlRequest)
        return  try jsonDecoder.decode(Dogs.self, from: responseData.0)
        }
    private func obtainCatData() async throws -> [Cat]{
        var url: URL = URL(string: "https://api.thecatapi.com/v1/images/search?limit=8")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let responseData = try await urlSession.data(for: urlRequest)
        return  try jsonDecoder.decode([Cat].self, from: responseData.0)
    }
    func downloadImage(for cardType: CardType) async throws -> [UIImage] {
        var url: URL
        switch cardType {
            case .dog:
            let dogs:Dogs = try await obtainDogsData()
            var dogsImages: [UIImage] = []
            for dog in dogs.message {
                print(dog)
                url = URL(string: dog)!
                var urlRequest = URLRequest(url: url)
                let data = try await urlSession.data(for: urlRequest)
            dogsImages.append(UIImage(data: data.0)!)
            }
            print(dogsImages)
            return dogsImages
            case .cat:
            let cats:[Cat] = try await obtainCatData()
            var catImages : [UIImage] = []
            for cat in cats {
                print(cat.url)
                url = URL(string: cat.url)!
                var urlRequest = URLRequest(url: url)
                let data = try await urlSession.data(for: urlRequest)
                catImages.append(UIImage(data: data.0)!)
            }
            return catImages
        default:
            return []
        }
        
    }
}
