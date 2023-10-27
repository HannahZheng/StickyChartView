//
//  StickyCell.swift
//  BeiBei
//
//  Created by Han on 2023/10/25.
//

import UIKit

final class StickyCell: UICollectionViewCell {
    private(set) lazy var label = BorderLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
private extension StickyCell {
    func buildUI() {
        contentView.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        contentView + label
    }
}

extension StickyCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.duobo.frame = bounds
    }
    
}
