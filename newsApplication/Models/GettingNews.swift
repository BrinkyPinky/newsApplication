//
//  GettingNews.swift
//  newsApplication
//
//  Created by Егор Шилов on 17.07.2022.
//

import UIKit

var saveNews: [dataForGetNews]?

struct getNews: Decodable {
    var data: [dataForGetNews]
}

struct dataForGetNews: Decodable {
    var author: String?
    var date: String?
    var title: String?
    var image: String?
}
