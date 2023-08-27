import Foundation
import UIKit

// MARK: - extension UIScrollView

extension UIScrollView {
    func indexPathForSubview(_ subview: UIView) -> IndexPath? {
        for (index, cell) in subviews.enumerated() {
            if cell === subview {
                let row = index / 2
                let column = index % 2
                return IndexPath(row: row, section: column)
            }
        }
        return nil
    }
}
