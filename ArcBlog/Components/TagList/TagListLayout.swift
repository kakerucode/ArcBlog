//
//  TagListLayout.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/4.
//

import Foundation
import SwiftUICore

struct TagListLayout: Layout {
    private let horizontalSpacing: CGFloat = 2.0
    private let verticalSpacing: CGFloat = 2.0
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows: Int = calculateNumberOrRow(for: subviews, with: proposal.width ?? 0)
        let subviewMaxHeight: CGFloat = subviews.map { $0.sizeThatFits(proposal).height }.reduce(0) { max($0, $1).rounded(.up) }
        let height: CGFloat = CGFloat(rows) * subviewMaxHeight + max(CGFloat(rows) - 1, 0) * verticalSpacing
        return CGSize(width: proposal.width ?? 0, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let subviewMaxHeight: CGFloat = subviews.map { $0.sizeThatFits(proposal).height }.reduce(0) { max($0, $1).rounded(.up) }
        var pt: CGPoint = .init(x: bounds.minX, y: bounds.minY)

        for subview in subviews.sorted(by: { $0.priority > $1.priority }) {
            let width = subview.sizeThatFits(proposal).width
            if (pt.x + width) > bounds.maxX {
                pt.x = bounds.minX
                pt.y += subviewMaxHeight + verticalSpacing
            }
            subview.place(at: pt, anchor: .topLeading, proposal: proposal)
            pt.x += width + horizontalSpacing
        }
    }
    
    private func calculateNumberOrRow(for subviews: Subviews, with width: Double) -> Int {
        var rows = 0
        var x: Double = 0
    
        for subview in subviews {
            let addedX: CGFloat = subview.sizeThatFits(.unspecified).width + horizontalSpacing
            let xWillBeyondBounds: Bool =  x + addedX > width
            if xWillBeyondBounds {
                x = 0
                rows += 1
            }
            x += addedX
        }
        if x > 0 {
            rows += 1
        }
        return rows
    }
}
