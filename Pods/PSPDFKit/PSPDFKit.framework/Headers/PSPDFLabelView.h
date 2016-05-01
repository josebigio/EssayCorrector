//
//  PSPDFLabelView.h
//  PSPDFKit
//
//  Copyright (c) 2012-2016 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "PSPDFEnvironment.h"

typedef NS_ENUM(NSUInteger, PSPDFLabelStyle) {
    /// Single color. Default on iPhone 4.
    PSPDFLabelStyleFlat,
    /// Uses blur.
    PSPDFLabelStyleModern
} PSPDF_ENUM_AVAILABLE;

NS_ASSUME_NONNULL_BEGIN

/// Base class to show a semi-transparent, rounded label.
PSPDF_CLASS_AVAILABLE @interface PSPDFLabelView : UIView

/// `UILabel` used internally to show the text.
@property (nonatomic, readonly) UILabel *label;

/// Margin that is between the text and this view. Defaults to 2 on iPhone and 3 on iPad.
@property (nonatomic) CGFloat labelMargin UI_APPEARANCE_SELECTOR;

/// Customize label style. Defaults to `PSPDFLabelStyleModern`.
/// The styles match the `buttonStyle` values on `PSPDFBackForwardButton`.
/// @note iPhone 4 is special-cased here, since it doesn't support live-blur,
/// so it will fall back to `PSPDFLabelStyleFlat`.
@property (nonatomic) PSPDFLabelStyle labelStyle UI_APPEARANCE_SELECTOR;

/// Customize the blur effect style used.
/// Defaults to `UIBlurEffectStyleDark`.
@property (nonatomic) UIBlurEffectStyle blurEffectStyle UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
