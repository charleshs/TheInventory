//
//  TextField.swift
//  TheInventory-ios
//
//  Created by Charles Hsieh on 2021/7/29.
//

import UIKit

open class TextField: UITextField {

    public var contentInsets: UIEdgeInsets {
        get { return textRectInsets }
        set { textRectInsets = newValue }
    }

    @IBInspectable
    public var insetTop: CGFloat {
        get { return textRectInsets.top }
        set { textRectInsets.top = newValue }
    }

    @IBInspectable
    public var insetLeft: CGFloat {
        get { return textRectInsets.left }
        set { textRectInsets.left = newValue }
    }

    @IBInspectable
    public var insetRight: CGFloat {
        get { return textRectInsets.right }
        set { textRectInsets.right = newValue }
    }

    @IBInspectable
    public var insetBottom: CGFloat {
        get { return textRectInsets.bottom }
        set { textRectInsets.bottom = newValue }
    }

    private var textRectInsets: UIEdgeInsets = .zero { didSet {
        setNeedsDisplay()
        invalidateIntrinsicContentSize()
    }}

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textRectInsets)
    }

    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
}
