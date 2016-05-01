//
//  PSPDFBrightnessViewController.h
//  PSPDFKit
//
//  Copyright (c) 2012-2016 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "PSPDFStaticTableViewController.h"
#import "PSPDFAppearanceModeManager.h"


NS_ASSUME_NONNULL_BEGIN

/// Controller to change the brightness and some related appearance options.
/// In addition to mimicking the system bigness options it also supports additional software dimming and social appearance modes.
/// @note Best presented as popover, configures the `modalPresentationStyle` accordingly at init time.
PSPDF_CLASS_AVAILABLE @interface PSPDFBrightnessViewController : PSPDFStaticTableViewController

/// @section Brightness

/// Enables software dimming. Defaults to YES.
@property (nonatomic) BOOL wantsSoftwareDimming;

/// Enables software dimming to make the screen really dark. Defaults to YES.
@property (nonatomic) BOOL wantsAdditionalSoftwareDimming;

/// Defaults to 0.3. Only relevant if `wantsAdditionalSoftwareDimming` is YES.
/// Especially for special use cases like airplane software that requires additional dimming.
@property (nonatomic) CGFloat additionalBrightnessDimmingFactor;

/// Defaults to 0.6. If you set this to 1 the screen will be *completely* dark.
/// Only relevant if `wantsAdditionalSoftwareDimming` is YES.
@property (nonatomic) CGFloat maximumAdditionalBrightnessDimmingFactor;

/// @section Appearance

/// The appearance manager responsible for the appearance mode.
/// The appearance UI is not shown if this property is `nil` (default value).
@property (nonatomic, nullable) PSPDFAppearanceModeManager *appearanceModeManager;

/// Possible appearance modes.
/// The appearance UI is not shown if only `PSPDFAppearanceModeDefault` is set (default value).
@property (nonatomic) PSPDFAppearanceMode allowedAppearanceModes;

@end

/// Dimming view that is added to the main UIWindow.
@interface PSPDFDimmingView : UIView

/// Software dimming factor.
@property (nonatomic) CGFloat additionalBrightnessDimmingFactor;

@end

@interface PSPDFBrightnessViewController (SubclassingHooks)

/// Used for additional software dimming.
@property (nonatomic, readonly) PSPDFDimmingView *dimmingView;

/// Returns the current dimming view or lazily creates a new one.
@property (nonatomic, readonly) PSPDFDimmingView *addDimmingView;

/// Removes the current dimming view.
- (void)removeDimmingView;

@end

NS_ASSUME_NONNULL_END
