import Foundation

enum Size: Float {
    case small = 0.2
    case normal = 0.4
}

enum Alignment {
    case center
    case left
    case right
}

struct Data {
    let alignment: Alignment
    let elements: [[Size]]
}
