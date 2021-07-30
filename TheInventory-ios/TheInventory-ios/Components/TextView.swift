//
//  TextView.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/29.
//

import UIKit

open class TextView: UITextView {

    @IBInspectable
    public var insetTop: CGFloat {
        get { return textContainerInset.top }
        set { textContainerInset.top = newValue }
    }

    @IBInspectable
    public var insetLeft: CGFloat {
        get { return textContainerInset.left }
        set { textContainerInset.left = newValue }
    }

    @IBInspectable
    public var insetRight: CGFloat {
        get { return textContainerInset.right }
        set { textContainerInset.right = newValue }
    }

    @IBInspectable
    public var insetBottom: CGFloat {
        get { return textContainerInset.bottom }
        set { textContainerInset.bottom = newValue }
    }

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initSetup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }

    open func initSetup() {}
}
