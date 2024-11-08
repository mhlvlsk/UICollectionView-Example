import UIKit

class ViewController: UIViewController {
    private var viewModel = ViewModel()

    lazy var collectionView: UICollectionView = {
        let layout = CollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = collectionView
        collectionView.backgroundColor = .white

        let Data = Data(
            alignment: .center,
            elements: [
                [.small, .normal, .small],
                [.normal, .small, .normal],
                [.small, .normal, .small],
                [.small]
            ]
        )
        viewModel.showData(Data, collectionView: collectionView)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = "\(indexPath.item)"
        return cell
    }
}
