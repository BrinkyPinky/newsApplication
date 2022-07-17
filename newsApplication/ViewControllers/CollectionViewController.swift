//
//  CollectionViewController.swift
//  newsApplication
//
//  Created by Егор Шилов on 17.07.2022.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Колво ячеек

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    // MARK: Запись в ячейки

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ViewCollectionViewCell
        gettingNews(cell: cell)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 10, height: 120)
    }
    // MARK: Получение новостей из сети
    func gettingNews(cell: ViewCollectionViewCell) {
        guard let url = URL(string: "http://api.mediastack.com/v1/news?access_key=e4dfa5101b6e71fc447d8a6f90e9a7ea&countries=ru&languages=ru") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            
            do {
                let news = try JSONDecoder().decode(getNews.self, from: data)
                
                DispatchQueue.main.async {
                    cell.newsTitle.text = news.data.first?.title
                    cell.newsAuthor.text = news.data.first?.author
                    guard let imageURL = URL(string: news.data.first?.image ?? "https://www.baumer.com/medias/sys_master/root/h86/h4d/8954759118878/placeholder-conversion-original-720Wx540H-retina.png") else {return}
                    guard let imageData = try? Data(contentsOf: imageURL) else { return }
                    
                    cell.newsImage.image = UIImage(data: imageData)
                    saveNews = news.data
                }
                
                
            } catch {
                print(error)
            }
        }.resume()
    }
}
