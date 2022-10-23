//
//  NetworkService.swift
//  SportImages
//
//  Created by Kyzu on 19.10.22.
//

import Foundation

class NetworkService {
    
    func request(searchTerm: String, pageNumber: Int, completion: @escaping (Data?, Error?) -> Void ) {
        let parameters = self.prepareParameters(searchTerm: searchTerm, pageNumber: pageNumber)
        let url = self.url(params: parameters)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID qHBA_Snp5lU1DTxfo69ymH05FVOUITIaryVNos3rvH0"
        return headers
    }
    
    private func prepareParameters(searchTerm: String?, pageNumber: Int) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(pageNumber)
        parameters["per_page"] = "30"
        parameters["orientation"] = "portrait"
        return parameters
    }
    
    private func url(params: [String : String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
