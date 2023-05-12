//
//  ViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Kyaw Zay Ya Lin Tun on 12/05/2023.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var footer: Footer?

    private let colors: [UIColor] = [.systemRed, .systemGreen, .systemBlue, .systemYellow, .systemPurple]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        self.title = "Hello"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(Footer.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 12)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.4))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 4, trailing: 0)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomLeading)
            ]
            
            section.visibleItemsInvalidationHandler = { visibleItem, contentOffset, evn in
                let screenWidth = self.view.bounds.width
                let cellWidth = screenWidth * 0.8
                let padding = (screenWidth - cellWidth) / 2
                let offsetX = contentOffset.x + padding
                
                self.footer?.currentPage = Int(offsetX / cellWidth)
            }
            
            return section
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath) as? Footer
        footer?.numberOfPages = colors.count
        return footer!
    }
}
