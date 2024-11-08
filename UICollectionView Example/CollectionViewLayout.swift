import UIKit

class CollectionViewLayout: UICollectionViewLayout {
    private var attributesCache: [UICollectionViewLayoutAttributes] = []
    private var contentSize: CGSize = .zero
    private var data: Data?

    private let itemSpacing: CGFloat = 20
    private let itemHeight: CGFloat = 40

    func updateLayout(with data: Data) {
        self.data = data
        invalidateLayout() 
    }

    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView, let data = data else { return }

        attributesCache.removeAll()
        
        var yOffset: CGFloat = 0
        let screenWidth = collectionView.bounds.width

        for row in data.elements {
            let totalSpacing = CGFloat(row.count - 1) * itemSpacing
            let availableWidth = screenWidth - totalSpacing
            
            let totalRowWidthWithoutSpacing = row.reduce(0.0) { $0 + CGFloat($1.rawValue) * availableWidth }

            var xOffset: CGFloat = 0

            switch data.alignment {
            case .center:
                xOffset = (screenWidth - totalRowWidthWithoutSpacing - totalSpacing) / 2
            case .left:
                xOffset = 0
            case .right:
                xOffset = screenWidth - totalRowWidthWithoutSpacing - totalSpacing
            }
            
            for size in row {
                let itemWidth = CGFloat(size.rawValue) * availableWidth
                let indexPath = IndexPath(item: attributesCache.count, section: 0)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemWidth, height: itemHeight)
                attributesCache.append(attributes)

                xOffset += itemWidth + itemSpacing
            }
            yOffset += itemHeight + itemSpacing
        }

        contentSize = CGSize(width: screenWidth, height: yOffset)
    }

    override var collectionViewContentSize: CGSize {
        return contentSize
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesCache.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesCache[indexPath.item]
    }
}
