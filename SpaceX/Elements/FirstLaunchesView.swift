//
//  FirstLaunchesView.swift
//  SpaceX
//
//  Created by Богдан Баринов on 02.08.2022.
//

import UIKit

final class FirstLaunchesView: UIView {

    // MARK: - Private properties

    private lazy var stackView = makeStackView()
    private lazy var firstLabel = makeTitleLabel()
    private lazy var secondLabel = makeSubTitleLabel()

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

        addSubview(stackView)
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)

        setUpConstraints()
    }

    private func setUpConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Configurable

extension FirstLaunchesView {

    @discardableResult
    func configured(with model: RocketInfoModel) -> Self {
        firstLabel.text = model.title
        secondLabel.text = model.subTitle
        return self
    }
}

// MARK: - Factory

private extension FirstLaunchesView {

    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }

    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 202/255.0, green: 202/255.0, blue: 202/255.0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }

    func makeSubTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 142/255.0, green: 142/255.0, blue: 143/255.0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }
}

// MARK: - Constants

private extension FirstLaunchesView {

    enum Constants {
    }
}
