//
//  PSPDFReachability.h
//  PSPDFModel
//
//  Copyright (c) 2015-2016 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "PSPDFEnvironment.h"

typedef NS_ENUM(NSUInteger, PSPDFReachability) {
    PSPDFReachabilityUnknown,
    PSPDFReachabilityUnreachable,
    PSPDFReachabilityWiFi,
    /// iOS only
    PSPDFReachabilityWWAN
} PSPDF_ENUM_AVAILABLE;
