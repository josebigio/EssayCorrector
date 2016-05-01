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

PSPDF_AVAILABLE_DECL @protocol PSPDFApplication <NSObject>

- (BOOL)canOpenURL:(NSURL *)url;
- (void)openURL:(NSURL *)URL completionHandler:(nullable void (^)(BOOL success))completionHandler;

@property (nonatomic, readonly) id <PSPDFNetworkActivityIndicatorManager> networkIndicatorManager;

@end

NS_ASSUME_NONNULL_END
