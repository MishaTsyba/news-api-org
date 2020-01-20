//
//  SearchInputController.swift
//  news-org-api
//
//  Created by Mykhailo Tsyba on 1/16/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit

class SearchInputController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var searchTetxField: UITextField!
	@IBOutlet weak var searchButton: UIButton!
	@IBOutlet weak var inputBackgroundView: UIView!

	var newsArray = [NewsModel]()
	var newsResponce: [String: Any]?
	var newsCount = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
		designUI()
		let keyboardHide = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
		view.addGestureRecognizer(keyboardHide)

		searchTetxField.delegate = self
    }

	@objc func keyboardWillHide() {
		self.view.endEditing(true)
	}

	@IBAction func didTapSearchButton(_ sender: Any) {
		let url = URL(string: "https://newsapi.org/v2/everything?q=" + (searchTetxField.text ?? "") + "&from=2019-12-28&to=2020-01-12&pageSize=100")

		if let url = url {
			var urlRequest = URLRequest(url: url)
			urlRequest.allHTTPHeaderFields = ["X-Api-Key": "fbd6fda585054e02b88a99eb96d5f676"]
			urlRequest.httpMethod = "GET"

			let session = URLSession.shared

			session.dataTask(with: urlRequest) { (data, response, error) in
				if let jsonData = data {
					do {
						let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]

						if let totalResults = json?["totalResults"] as? Int, totalResults == 0 {
							debugPrint("Total 0")
						} else {
							self.newsCount = json?["totalResults"] as? Int ?? 0

							if let articles = json?["articles"] as? [[String: Any]] {

								for article in articles {

									let news = NewsModel()

									if let title = article["title"] as? String {
										news.title = title
										debugPrint(title)
									}

									if let description = article["description"] as? String {
										news.description = description
										debugPrint(description)
									}

									if let url = article["url"] as? String {
										news.url = url
										debugPrint(url)
									}

									if let urlToImage = article["urlToImage"] as? String {
										news.urlToImage = urlToImage
										debugPrint(urlToImage)
									}

									if let publishedAt = article["publishedAt"] as? String {
										news.publishedAt = publishedAt
										debugPrint(publishedAt)
									}
									self.newsArray.append(news)
								}

								DispatchQueue.main.async {
									debugPrint(self.newsArray)
									if self.newsCount > 0 {
										let storyboard = UIStoryboard(name: "Main", bundle: nil)
										let vc = storyboard.instantiateViewController(withIdentifier: "SearchResultController") as! SearchResultController

										debugPrint("shit before data transfer")
										vc.newsArray = self.newsArray
										debugPrint("shit after data transfer")

										self.navigationController?.pushViewController(vc, animated: true)
									} else {
										debugPrint("shit")
									}
								}
							}
						}
					} catch {
						debugPrint(error)
					}
					debugPrint(self.newsArray)
				}
			}.resume()
			debugPrint(self.newsArray)
		}
	}
}


extension SearchInputController {
	func designUI() {
		inputBackgroundView.clipsToBounds = true
		inputBackgroundView.layer.cornerRadius = 10
	}
}
