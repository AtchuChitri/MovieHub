//
//  Array+SafeIndex.swift
//  MovieHub
//
//  Created by Atchu on 8/2/23.
//

import Foundation

public extension Array {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
