//
//  CellView.swift
//  Demiurge  Shambambukli
//
//  Created by Fedor Bebinov on 20.09.2024.
//

import UIKit

enum Entity {
    case alive
    case dead
    case exsistance
}

class CellView: UIView{
    
    private var cellType: Entity
    
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        switch cellType {
        case .alive:
            imageView.image = UIImage(resource: .alive)
        case .dead:
            imageView.image = UIImage(resource: .dead)
        case .exsistance:
            imageView.image = UIImage(resource: .existance)
        }
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        switch cellType {
        case .alive:
            label.text = "Живая"
        case .dead:
            label.text = "Мёртвая"
        case .exsistance:
            label.text = "Жизнь"
        }
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        switch cellType {
        case .alive:
            label.text = "И шевелится!"
        case .dead:
            label.text = "Или прикидывается"
        case .exsistance:
            label.text = "Ку-ку!"
        }
        
        return label
    }()
    
    init(type: Entity) {
        cellType = type
        super.init(frame: .zero)
        self.backgroundColor = .white
        layer.cornerRadius = 5
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        addSubview(cellImageView)
        cellImageView.pin(to: self, [.top, .bottom, .left], 16)
        
        addSubview(titleLabel)
        titleLabel.pinLeft(to: self, 72)
        titleLabel.pinTop(to: self, 16)
        
        addSubview(textLabel)
        textLabel.pinLeft(to: self, 72)
        textLabel.pinTop(to: self, 43)
    }
}
