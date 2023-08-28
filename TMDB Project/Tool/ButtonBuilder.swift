//
//  ButtonBuilder.swift
//  SwiftyComponent
//
//  Created by 정준영 on 2023/08/28.
//

import UIKit

struct ButtonBuilder {
    var button = UIButton()
    
    enum ButtonStyle {
        case plain
        case tinted
        case gray
        case filled
        case borderless
        case bordered
        case borderedTinted
        case borderedProminent
    }
    
    init(_ style: ButtonStyle) {
        switch style {
        case .plain:
            button.configuration = UIButton.Configuration.plain()
        case .tinted:
            button.configuration = UIButton.Configuration.tinted()
        case .gray:
            button.configuration = UIButton.Configuration.gray()
        case .filled:
            button.configuration = UIButton.Configuration.filled()
        case .borderless:
            button.configuration = UIButton.Configuration.borderless()
        case .bordered:
            button.configuration = UIButton.Configuration.bordered()
        case .borderedTinted:
            button.configuration = UIButton.Configuration.borderedTinted()
        case .borderedProminent:
            button.configuration = UIButton.Configuration.borderedProminent()
        }
    }
    
    /// This method must be used at the end of the syntax.
    /// - Returns: UIButton
    func makeButton() -> UIButton {
        return button
    }
    // MARK: - BaseColor

    /// Button's Background Color : Highlight Color Enable
    /// - Parameter color: UIColor
    /// - Returns: ButtonBuilder
    func baseBackgroundColor(_ color: UIColor) -> Self {
        button.configuration?.baseBackgroundColor = color
        return self
    }
    
    /// Button's Tint Color
    /// - Parameter color: UIColor
    /// - Returns: ButtonBuilder
    func baseForegroundColor(_ color: UIColor) -> Self {
        button.configuration?.baseBackgroundColor = color
        return self
    }
    
    // MARK: - Title

    func title(_ text: String) -> Self {
        button.configuration?.title = text
        return self
    }
    
    func titleWithFont(title: String, size: CGFloat, weight: UIFont.Weight) -> Self {
        var titleAttr = AttributedString(title)
        titleAttr.font = .systemFont(ofSize: size, weight: weight)
        button.configuration?.attributedTitle = titleAttr
        return self
    }
    
    func titleAlignment(_ alignment: UIButton.Configuration.TitleAlignment) -> Self {
        button.configuration?.titleAlignment = alignment
        return self
    }
    
    func titlePadding(_ padding: CGFloat) -> Self {
        button.configuration?.titlePadding = padding
        return self
    }
    
    func subtitle(_ text: String) -> Self {
        button.configuration?.subtitle = text
        return self
    }
    
    func subtitleWithFont(title: String, size: CGFloat, weight: UIFont.Weight) -> Self {
        var titleAttr = AttributedString(title)
        titleAttr.font = .systemFont(ofSize: size, weight: weight)
        button.configuration?.attributedSubtitle = titleAttr
        return self
    }
    
    func image(_ image: UIImage?) -> Self {
        button.configuration?.image = image
        return self
    }
    
    // MARK: - Corner & Border

    func cornerStyle(_ cornerStyle: UIButton.Configuration.CornerStyle) -> Self {
        button.configuration?.cornerStyle = cornerStyle
        return self
    }
    
    func borderColor(_ color: UIColor) -> Self {
        button.configuration?.background.strokeColor = color
        return self
    }
    
    func borderWidth(_ width: CGFloat) -> Self {
        button.configuration?.background.strokeWidth = width
        return self
    }
    
    func cornerRadius(_ radius: CGFloat) -> Self {
        button.configuration?.background.cornerRadius = radius
        return self
    }
    
    // MARK: - Padding & Inset

    func imagePadding(_ padding: CGFloat) -> Self {
        button.configuration?.imagePadding = padding
        return self
    }
    
    func imagePlacement(_ placement: NSDirectionalRectEdge) -> Self {
        button.configuration?.imagePlacement = placement
        return self
    }
    
    func contentInsets(_ insets: NSDirectionalEdgeInsets) -> Self {
        button.configuration?.contentInsets = insets
        return self
    }
    
    func buttonSize(_ size: UIButton.Configuration.Size) -> Self {
        button.configuration?.buttonSize = size
        return self
    }
    
    // MARK: - Indicator

    func showsActivityIndicator(_ bool: Bool) -> Self {
        button.configuration?.showsActivityIndicator = bool
        return self
    }
    
    // MARK: - Add Closure

    func addAction(_ action: @escaping (() -> ()), for event: UIControl.Event = .touchUpInside) -> Self {
        let identifier = UIAction.Identifier(String(describing: event.rawValue))
        let action = UIAction(identifier: identifier) { _ in
            action()
        }
        button.removeAction(identifiedBy: identifier, for: event)
        button.addAction(action, for: event)
        return self
    }
    
    func addConfigurationUpdateHandler(_ action: @escaping UIButton.ConfigurationUpdateHandler) -> Self {
        button.configurationUpdateHandler = action
        return self
    }
}
