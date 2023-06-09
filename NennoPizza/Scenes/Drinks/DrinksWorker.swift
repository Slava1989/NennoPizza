//
//  DrinksWorker.swift
//  NennoPizza
//
//  Created by Slava Chirita on 08.06.2023.
//

import Foundation

protocol DrinksWorkerInterface: AnyObject {
    func fetchDrinks(onComplete: @escaping (_ response: [DrinksScreen.FetchDrinks.Drinks]?, String?) -> ())
}

final class DrinksWorker: DrinksWorkerInterface {
    func fetchDrinks(onComplete: @escaping ([DrinksScreen.FetchDrinks.Drinks]?, String?) -> ()) {
        guard let url = URL(string: DrinksScreen.FetchDrinks.Request.url.rawValue) else {
            onComplete(nil, "Wrong URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                onComplete(nil, "Something went wrong during drinks request")
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                onComplete(nil, "Wrong access")
                return
            }
            
            do {
                let drinks = try JSONDecoder().decode([DrinksScreen.FetchDrinks.Drinks].self, from: data)
                onComplete(drinks, nil)
            } catch {
                onComplete(nil, "Error while decoding drinks data")
            }
        }.resume()
    }
}
