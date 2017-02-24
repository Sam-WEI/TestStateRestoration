//
//  PetNetworking.swift
//  PetFinder
//
//  Created by Luke Parham on 8/31/15.
//  Copyright © 2015 Luke Parham. All rights reserved.
//

import Foundation
import UIKit

class PetNetworking {
    class func fetchImageAtURL(_ url:String, success:@escaping (UIImage?) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            if let response = response, let data = data, response.isHTTPResponseValid() {
                success(UIImage(data: data))
            }
        }) 
    }
}
