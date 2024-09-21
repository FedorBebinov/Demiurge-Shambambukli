//
//  ViewController.swift
//  Demiurge  Shambambukli
//
//  Created by Fedor Bebinov on 20.09.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private var existanceCell: CellView?
    private var lastCells: [Entity] = []
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Клеточное наполнение"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            return scrollView
        }()
    
    private lazy var contentView: UIView = {
            let view = UIView()
            return view
        }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сотворить", for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cellsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .center
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setupLayout()
    }
    
    private func setGradientBackground(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupLayout(){
        view.addSubview(createButton)
        createButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, 16)
        createButton.pin(to: view, [.left, .right], 16)
        
        view.addSubview(scrollView)
        scrollView.pin(to: view, .left, .right)
        scrollView.pinBottom(to: createButton.topAnchor, 80)
        scrollView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        scrollView.addSubview(contentView)
        
        contentView.pin(to: scrollView)
        contentView.pinWidth(to: scrollView.widthAnchor)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1)
        height.isActive = true
        height.priority = UILayoutPriority(50)
        
        contentView.addSubview(headerLabel)
        headerLabel.pinTop(to: contentView, 16)
        headerLabel.pinCenter(to: contentView.centerXAnchor)
        headerLabel.setHeight(to: 28)
        headerLabel.setWidth(to: 329)
        
        contentView.addSubview(cellsStackView)
        cellsStackView.pinTop(to: headerLabel.bottomAnchor, 12)
        cellsStackView.pin(to: contentView, [.left, .right], 16)
        cellsStackView.pinBottom(to: contentView)
        
        
    }
    func workWithExistance(){
        if lastCells.count == 3 && lastCells[0] == lastCells[1] && lastCells[1] == lastCells[2] && lastCells[0] == lastCells[2]{
            
            if lastCells[0] == .alive{
                lastCells.removeAll()
                let extistanceCell = CellView(type: .exsistance)
                extistanceCell.setWidth(to: 328)
                extistanceCell.setHeight(to: 72)
                existanceCell = extistanceCell
                
                let secondsToDelay = 0.5
                DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                    self.cellsStackView.addArrangedSubview(extistanceCell)
                    self.scrollDownIfNeeded()
                }
                
            } else if lastCells[0] == .dead {
                lastCells.removeAll()
                if let cellToDelete =  existanceCell{
                    
                    let secondsToDelay = 0.5
                    DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                        self.cellsStackView.removeArrangedSubview(cellToDelete)
                        cellToDelete.removeFromSuperview()
                        self.existanceCell = nil
                    }
                }
            }
        }
    }
    func scrollDownIfNeeded() {
        if scrollView.contentSize.height + 100 < scrollView.bounds.size.height || cellsStackView.arrangedSubviews.count < 2 { return }
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height + 100)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    @objc
    func createButtonTapped(){
        let isAlive = Bool.random()
        let randomType = isAlive ? Entity.alive : Entity.dead
        
        let customCell = CellView(type: randomType)
        customCell.setWidth(to: 328)
        customCell.setHeight(to: 72)
        
        cellsStackView.addArrangedSubview(customCell)
        scrollDownIfNeeded()
        
        if lastCells.count == 3 {
            lastCells.removeFirst()
            
        }
        lastCells.append(randomType)
        
        workWithExistance()
       
    }
}


