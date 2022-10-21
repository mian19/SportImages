//
//  NetworkDataFetcher.swift
//  SportImages
//
//  Created by Kyzu on 19.10.22.
//

import Foundation

class NetworkDataFetcher {
   
    var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, pageNumber: Int, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(searchTerm: searchTerm, pageNumber: pageNumber) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
}
