//
//  CustomProgressBar.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 01.04.2025.
//

import SnapKit
import UIKit

final class CustomProgressBar: UIView {
    
    // MARK: Constants
    
    private enum Constants {
        static let backgruondHeight = 8.0
        static let spacing = 2.0
    }
    
    // MARK: Internal properties
    
    /// прогресс от 0 до 100
    var progress: Int = 0 {
        didSet {
            progressBarWidthConstraint?.update(offset: progressBarWidth)
        }
    }
    
    // MARK: Private properties
        
    private var progressBarWidthConstraint: Constraint?
    
    private var progressBarWidth: CGFloat {
        return min((frame.width - 2 * Constants.spacing) * (Double(progress) / 100), frame.width - 2 * Constants.spacing)
    }
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .orangeDark
        return view
    }()
    
    // MARK: Inititalization
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCornerRadius()
    }
}

private extension CustomProgressBar {
    
    func setupUI() {
        backgroundColor = .orangeLight
        addSubviews()
    }
    
    func addSubviews() {
        addSubview(progressView)
        configureLayout()
    }
    
    func configureLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(Constants.backgruondHeight)
        }
        
        progressView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(Constants.spacing)
            progressBarWidthConstraint = make.width.equalTo(progressBarWidth).constraint
        }
    }
    
    func setupCornerRadius() {
        layer.cornerRadius = layer.frame.height / 2
        progressView.layer.cornerRadius = progressView.layer.frame.height / 2
    }
}
