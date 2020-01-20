//
//  SearchResultController.swift
//  news-org-api
//
//  Created by Mykhailo Tsyba on 1/16/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit

class SearchResultController: UIViewController {


	@IBOutlet weak var newsTableView: UITableView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var backgroundView: UIView!

	var newsArray = [NewsModel]()
	var newsResponce: [String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
		debugPrint("results")
		debugPrint(newsArray)
		debugPrint(newsArray.count)
		designUI()
		titleLabel.text = "Total news: \(newsArray.count)"
		newsTableView.delegate = self
		newsTableView.dataSource = self
		newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
		newsTableView.reloadData()
        // Do any additional setup after loading the view.
    }

	@IBAction func didTapBackButton(_ sender: Any) {

		let storyboard = UIStoryboard()
		let vc = storyboard.instantiateViewController(withIdentifier: "SearchInputController") as! SearchInputController

		newsArray = []
		vc.newsArray = self.newsArray
		navigationController?.popToViewController(vc, animated: true)
	}


}

//MARK: - UITableViewDelegate Extension

extension SearchResultController: UITableViewDelegate, UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return newsArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
		cell.updateNewsCell(news: newsArray[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

extension SearchResultController {
	func designUI() {
		backgroundView.clipsToBounds = true
		backgroundView.layer.cornerRadius = 10
	}
}
