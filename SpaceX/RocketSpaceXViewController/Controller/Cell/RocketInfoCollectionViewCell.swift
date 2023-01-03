//
//  RocketInfoCollectionViewCell.swift
//  SpaceX
//
//  Created by Богдан Баринов on 10.09.2022.
//

import UIKit

final class RocketInfoCollectionViewCell: UICollectionViewCell {

    // MARK: - Private properties

    private lazy var containerView = makeContainerView()
    private lazy var stackView = makeStackView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subTitleLabel = makeSubTitleLabel()

    // MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Private methods

    private func setupUI() {
        backgroundColor = .clear

        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)

        setUpConstraints()
    }

    private func setUpConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 96),
            containerView.widthAnchor.constraint(equalToConstant: 96),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
}

// MARK: - Configurable

extension RocketInfoCollectionViewCell {

    @discardableResult
    func configured(with model: RocketInfoModel) -> Self {
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
        return self
    }
}

// MARK: - Factory

private extension RocketInfoCollectionViewCell {

    func makeContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
        view.layer.cornerRadius = 32
        view.layer.masksToBounds = true
        return view
    }

    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }

    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 248/255.0, green: 243/255.0, blue: 234/255.0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }

    func makeSubTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 142/255.0, green: 142/255.0, blue: 143/255.0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }
}

// MARK: - Constants

private extension RocketInfoCollectionViewCell {

    enum Constants {
    }
}
