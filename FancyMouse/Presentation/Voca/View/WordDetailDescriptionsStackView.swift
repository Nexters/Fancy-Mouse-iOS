//
//  WordDetailDescriptionsStackView.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/24.
//

import UIKit

final class WordDescriptionsStackView: UIStackView {
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubDescriptionViews(with details: [WordDetailDescription]) {
        details.forEach { detail in
            addSubDetailDescriptionView(with: detail)
        }
    }
}
    
private extension WordDescriptionsStackView {
    func setup() {
        axis = .vertical
        distribution = .equalSpacing
        alignment = .fill
        spacing = 16
    }
    
    func addSubDetailDescriptionView(with detail: WordDetailDescription) {
        let detailView = WordDetailDescriptionView()
        detailView.title = detail.title
        detailView.descriptionString = detail.description
        detailView.titleLabelColor = detail.color
        
        addArrangedSubview(detailView)
    }
}
