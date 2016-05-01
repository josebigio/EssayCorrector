//
//  PSPDFBackForwardButton.h
//  PSPDFKit
//
//  Copyright (c) 2015-2016 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "PSPDFButton.h"

typedef NS_ENUM(NSUInteger, PSPDFBackButtonStyle) {
    /// Single color. Default on iPhone 4.
    PSPDFBackButtonStyleFlat,
    /// Uses blur.
    PSPDFBackButtonStyleModern
} PSPDF_ENUM_AVAILABLE;

NS_ASSUME_NONNULL_BEGIN

/// Back and forward buttons, used for the action stack navigation.
PSPDF_CLASS_AVAILABLE @interface PSPDFBackForwardButton : PSPDFButton

/// Returns a button pre-configured for the back button style.
+ (instancetype)backButton;

/// Returns a button pre-configured for the forward button style.
+ (instancetype)forwardButton;

/// Customize the button style. Defaults to `PSPDFBackButtonStyleModern`.
/// The styles match the `labelStyle` values on `PSPDFLabelView`.
/// @note iPhone 4 is special-cased here, since it doesn't support live-blur,
/// so it will fall back to `PSPDFBackButtonStyleFlat`.
@property (nonatomic) PSPDFBackButtonStyle buttonStyle UI_APPEARANCE_SELECTOR;

/// Customize the blur effect style used.
/// Defaults to `UIBlurEffectStyleDark`.
@property (nonatomic) UIBlurEffectStyle blurEffectStyle UI_APPEARANCE_SELECTOR;

/// Convenience long press gesture recognizer.
/// Use `addTarget:action:` to perform custom actions when triggered.
@property (nonatomic, readonly) UILongPressGestureRecognizer *longPressRecognizer;

@end

NS_ASSUME_NONNULL_END
