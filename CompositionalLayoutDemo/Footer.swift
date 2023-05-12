//
//  Footer.swift
//  CompositionalLayoutDemo
//
//  Created by Kyaw Zay Ya Lin Tun on 12/05/2023.
//

import UIKit

class Footer: UICollectionReusableView {

    private var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .link
        pc.numberOfPages = 1
        return pc
    }()
    
    var numberOfPages = 1 {
        didSet {
            pageControl.numberOfPages = numberOfPages
        }
    }
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageControl)
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageControl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
