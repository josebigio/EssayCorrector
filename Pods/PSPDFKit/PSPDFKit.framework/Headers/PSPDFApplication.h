//
//  PSPDFApplication.h
//  PSPDFKit
//
//  Copyright (c) 2014-2016 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import <Foundation/Foundation.h>
#import "PSPDFNetworkActivityIndicatorManager.h"

NS_ASSUME_NONNULL_BEGIN

/// This class handles opening URLs for other applications
/// and coordinates access to the network indicator manager since this is restricted in an iOS extension case.
PSPDF_AVAILABLE_DECL @protocol PSPDFApplication <NSObject>

/// Returns a Boolean value indicating whether or not the URL’s scheme can be handled by some app installed on the device.
/// @see [UIApplication canOpenURL:]
- (BOOL)canOpenURL:(NSURL *)URL;

/// Asks the host to open an URL on the extension's behalf if we're in an extension context,
/// Else simply calls [UIApplication openURL:]
- (void)openURL:(NSURL *)URL completionHandler:(nullable void (^)(BOOL success))completionHandler;

/// Coordinates access to the network indicator manager.
@property (nonatomic, readonly) id <PSPDFNetworkActivityIndicatorManager> networkIndicatorManager;

@end

NS_ASSUME_NONNULL_END
