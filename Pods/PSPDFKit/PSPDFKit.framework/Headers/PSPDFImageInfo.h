//
//  PSPDFImageInfo.h
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

NS_ASSUME_NONNULL_BEGIN

@class PSPDFDocumentProvider;

/// Defines the position if an image in the PDF.
PSPDF_CLASS_AVAILABLE_SUBCLASSING_RESTRICTED @interface PSPDFImageInfo : NSObject <NSCopying, NSSecureCoding>

PSPDF_EMPTY_INIT_UNAVAILABLE

/// Init object with page and rotation.
- (instancetype)initWithIndex:(NSUInteger)index
                    pixelSize:(CGSize)pixelSize
                    transform:(CGAffineTransform)transform
                     vertices:(CGPoint const*)vertices
                         page:(NSUInteger)page
             documentProvider:(nullable PSPDFDocumentProvider *)documentProvider NS_DESIGNATED_INITIALIZER;

/// Content ID of the image in the page stream.
@property (nonatomic, readonly) NSUInteger index;

/// The pixel size of the image.
@property (nonatomic, readonly) CGSize pixelSize;

/// Transform that is applied to the image.
@property (nonatomic, readonly) CGAffineTransform transform; // global transform state.

/// The 4 points that define the image.
@property (nonatomic, readonly) CGPoint *vertices; // [4];

/// Associated document provider.
@property (nonatomic, weak, readonly) PSPDFDocumentProvider *documentProvider;

/// Page is relative to the document provider.
@property (nonatomic, readonly) NSUInteger page;

/// @name Calculated properties
@property (nonatomic, readonly) CGSize displaySize;
@property (nonatomic, readonly) CGFloat horizontalResolution;
@property (nonatomic, readonly) CGFloat verticalResolution;

/// Hit-Testing.
- (BOOL)hitTest:(CGPoint)point;

/// Rect that spans the 4 points.
@property (nonatomic, readonly) CGRect boundingBox;

/// The actual image. Will be extracted on the fly. Might have other dimensions than the displayed dimensions.
- (nullable UIImage *)imageWithError:(NSError **)error;

/// Some PDF images are in CMYK color space, which is not a supported encoding.
/// (`UIImageJPEGRepresentation` will return nil in that case)
/// This method checks against this case and converts the image into RGB color space.
- (nullable UIImage *)imageInRGBColorSpaceWithError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
