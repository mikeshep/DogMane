//
//  UIFont+nunito.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 05/03/21.
//

import UIKit

enum NunitoFontWeight: String {
    case regular = "Nunito-Regular"
    case italic = "Nunito-Italic"
    case light = "Nunito-Light"
    case lightItalic = "Nunito-LightItalic"
    case extraLight = "Nunito-ExtraLight"
    case extraLightItalic = "Nunito-ExtraLightItalic"
    case semiBold = "Nunito-SemiBold"
    case semiboldItalic = "Nunito-SemiBoldItalic"
    case bold = "Nunito-Bold"
    case boldItalic = "Nunito-BoldItalic"
    case extraBold = "Nunito-ExtraBold"
    case extraBoldItalic = "Nunito-ExtraBoldItalic"
    case black = "Nunito-Black"
    case blackItalic = "Nunito-BlackItalic"
}

extension UIFont {
    class func nunitoRegularFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .regular, andSize: size)
    }

    class func nunitoItalicFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .italic, andSize: size)
    }

    class func nunitoLightFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .light, andSize: size)
    }

    class func nunitoLightItalicFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .lightItalic, andSize: size)
    }

    class func nunitoExtraLightFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .extraLight, andSize: size)
    }

    class func nunitoExtraLightItalicFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .extraLightItalic, andSize: size)
    }

    class func nunitoSemiBoldFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .semiBold, andSize: size)
    }

    class func nunitoSemiBoldItalicFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .semiboldItalic, andSize: size)
    }

    class func nunitoBoldFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .bold, andSize: size)
    }

    class func nunitoBoldItalicFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .boldItalic, andSize: size)
    }

    class func nunitoExtraBoldFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .extraBold, andSize: size)
    }

    class func nunitoExtraBoldItalicFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .extraBoldItalic, andSize: size)
    }

    class func nunitoBlackFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .black, andSize: size)
    }

    class func nunitoBlackItalicFont(withSize size: CGFloat) -> UIFont {
        nunitoFont(withWeight: .blackItalic, andSize: size)
    }

    class func nunitoFont(withWeight weight: NunitoFontWeight, andSize size: CGFloat) -> UIFont {
        UIFont(name: weight.rawValue, size: size)!
    }
}

