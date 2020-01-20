//
//  NewsModel.swift
//  news-org-api
//
//  Created by Mykhailo Tsyba on 1/16/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import Foundation
import UIKit

class NewsModel {
	var status: String?
	var totalResults: String?
	var articles: [String: Any]?
	var source: [String: Any]?
	var id: String?
	var name: String?
	var author: String?
	var title: String?
	var description: String?
	var url: String?
	var urlToImage: String?
	var publishedAt: String?
	var content: String?
	var newsImage: UIImage?
}
