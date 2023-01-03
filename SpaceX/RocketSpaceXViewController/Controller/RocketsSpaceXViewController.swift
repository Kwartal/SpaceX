//
//  RocketSpaceXViewController.swift
//  SpaceX
//
//  Created by Богдан Баринов on 02.08.2022.
//

import UIKit

// MARK: - RocketSpaceXViewController

final class RocketSpaceXViewController: UIViewController {

    // MARK: - Private properties

    private var rockets: [Rockets]?
    private var networkLayer: INetworkService?

    private lazy var scrollView = makeScrollView()
    private lazy var containerView = UIView()
    private lazy var rocketPhotoImageView = makeRocketPhotoImageView()
    private lazy var backgroundView = makeBackgroundView()
    private lazy var nameLabel = makeNameLabel()
    private lazy var collectionView = makeCollectionView()
    private lazy var collectionViewFlowLayout = makeCollectionViewFlowLayout()
    private lazy var firstLaunchesStackView = makeStackView()

    private lazy var firstStageLabel = makeFirstStageLabel(text: "ПЕРВАЯ СТУПЕНЬ")
    private lazy var firstStageStackView = makeStackView()

    private lazy var secondStageLabel = makeFirstStageLabel(text: "ВТОРАЯ СТУПЕНЬ")
    private lazy var secondStageStackView = makeStackView()


    private lazy var urlPhoto = String()
    private lazy var items = [RocketInfoModel]()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }

    // MARK: Private methods

    private func loadData() {
        networkLayer = NetworkService()
        networkLayer?.fetchResult(complition: { [weak self] item in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch item {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.nameLabel.text = data[0].name
                    self.setupPhoto(url: data[0].flickrImages[0])
                    self.items.append(RocketInfoModel(title: String(data[0].height.feet), subTitle: "Высота, ft"))
                    self.items.append(RocketInfoModel(title: String(data[0].diameter.feet), subTitle: "Диаметр, ft"))
                    self.items.append(RocketInfoModel(title: String(data[0].mass.lb), subTitle: "Масса, lb"))
                    self.items.append(RocketInfoModel(title: String(data[0].payloadWeights[0].lb), subTitle: "Нагрузка, lb"))
                    self.firstLaunchesStackView.addArrangedSubview(FirstLaunchesView().configured(with: RocketInfoModel(title: "Первый запуск", subTitle: data[0].firstFlight)))
                    self.firstLaunchesStackView.addArrangedSubview(FirstLaunchesView().configured(with: RocketInfoModel(title: "Страна", subTitle: data[0].country)))
                    self.firstLaunchesStackView.addArrangedSubview(FirstLaunchesView().configured(with: RocketInfoModel(title: "Стоимость запуска", subTitle: String(data[0].costPerLaunch))))
                    self.firstStageStackView.addArrangedSubview(FirstLaunchesView().configured(with: RocketInfoModel(title: "Количество двигателей", subTitle: String(data[0].firstStage.engines))))
                    self.firstStageStackView.addArrangedSubview(FirstLaunchesView().configured(with: RocketInfoModel(title: "Количество топлива", subTitle: String(data[0].firstStage.fuelAmountTons))))
                    if data[0].firstStage.burnTimeSec != nil {
                        self.firstStageStackView.addArrangedSubview(FirstLaunchesView().configured(with: RocketInfoModel(title: "Время сгорания", subTitle: String(data[0].firstStage.burnTimeSec!))))
                    }
                    self.secondStageStackView.addArrangedSubview(FirstLaunchesView().configured(with: RocketInfoModel(title: "Количество двигателей", subTitle: String(data[0].secondStage.engines))))
                    self.secondStageStackView.addArrangedSubview(FirstLaunchesView().configured(with: RocketInfoModel(title: "Количество топлива", subTitle: String(data[0].secondStage.fuelAmountTons))))
                    if data[0].secondStage.burnTimeSec != nil {
                        self.secondStageStackView.addArrangedSubview(FirstLaunchesView().configured(with: RocketInfoModel(title: "Время сгорания", subTitle: String(data[0].secondStage.burnTimeSec!))))
                    }
                    self.collectionView.reloadData()
                }
            }
        })
    }

    private func setupPhoto(url: String) {
        guard let url = URL(string: url) else { return }
        rocketPhotoImageView.load(url: url)
    }
}

// MARK: - Setup

private extension RocketSpaceXViewController {

    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(rocketPhotoImageView)
        containerView.addSubview(backgroundView)
        backgroundView.addSubview(nameLabel)
        backgroundView.addSubview(collectionView)
        backgroundView.addSubview(firstLaunchesStackView)
        backgroundView.addSubview(firstStageLabel)
        backgroundView.addSubview(firstStageStackView)
        backgroundView.addSubview(secondStageLabel)
        backgroundView.addSubview(secondStageStackView)

        setUpConstraints()
    }

    func setUpConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        rocketPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rocketPhotoImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            rocketPhotoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            rocketPhotoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            rocketPhotoImageView.heightAnchor.constraint(equalToConstant: 300)
        ])

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: rocketPhotoImageView.bottomAnchor, constant: -30),
            backgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 48),
            nameLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32)
        ])

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 96),
            collectionView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])

        firstLaunchesStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLaunchesStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            firstLaunchesStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            firstLaunchesStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
        ])

        firstStageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstStageLabel.topAnchor.constraint(equalTo: firstLaunchesStackView.bottomAnchor, constant: 40),
            firstStageLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            firstStageLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
        ])

        firstStageStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstStageStackView.topAnchor.constraint(equalTo: firstStageLabel.bottomAnchor, constant: 16),
            firstStageStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            firstStageStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
        ])

        secondStageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondStageLabel.topAnchor.constraint(equalTo: firstStageStackView.bottomAnchor, constant: 40),
            secondStageLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            secondStageLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
        ])

        secondStageStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondStageStackView.topAnchor.constraint(equalTo: secondStageLabel.bottomAnchor, constant: 16),
            secondStageStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            secondStageStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
            secondStageStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -40)
        ])
    }

    func setupBinding() {
        loadData()
    }
}

// MARK: - UICollectionViewDataSource

extension RocketSpaceXViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as? RocketInfoCollectionViewCell else { return UICollectionViewCell() }
        cell.configured(with: items[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension RocketSpaceXViewController: UICollectionViewDelegate {

}

// MARK: - Factory

private extension RocketSpaceXViewController {

    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        return scrollView
    }

    func makeBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        return view
    }

    func makeRocketPhotoImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        return imageView
    }

    func makeNameLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 248/255.0, green: 243/255.0, blue: 234/255.0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }

    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(RocketInfoCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellId)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }

    func makeCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(
            width: 96,
            height: 96
        )
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        return layout
    }

    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }

    func makeFirstStageLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 248/255.0, green: 243/255.0, blue: 234/255.0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = text
        return label
    }
}

// MARK: - Constants

private extension RocketSpaceXViewController {

    enum Constants {
        static let cellId: String = "Cell"
    }
}
