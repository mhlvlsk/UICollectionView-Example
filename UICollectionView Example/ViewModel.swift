import UIKit

class ViewModel {
    private(set) var data: Data = Data(alignment: .center, elements: [])

    var totalItems: Int {
        return data.elements.flatMap { $0 }.count
    }

    func showData(_ newData: Data, collectionView: UICollectionView) {
        validate(data: newData)
        data = newData
        (collectionView.collectionViewLayout as? CollectionViewLayout)?.updateLayout(with: data)
        collectionView.reloadData()
    }

    private func validate(data: Data) {
        data.elements.forEach { row in
            guard !row.isEmpty else { fatalError("Row cannot be empty") }
            let totalWidth = row.reduce(0.0) { $0 + $1.rawValue }
            guard totalWidth <= 1.0 else { fatalError("Row width cannot be more than 1.0") }
        }
    }
}
