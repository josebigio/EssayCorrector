//
//  PSPDFThumbnailFlowLayout.h
//  PSPDFKit
//
//  Copyright (c) 2013-2016 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "PSPDFPresentationContext.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PSPDFThumbnailFlowLayoutAttributesType) {
    /// Marks attributes that relate to a single/standalone page.
    PSPDFThumbnailFlowLayoutAttributesTypeSingle,
    /// Marks attributes that relate to the left page in a two–page spread.
    PSPDFThumbnailFlowLayoutAttributesTypeLeft,
    /// Marks attributes that relate to the right page in a two–page spread.
    PSPDFThumbnailFlowLayoutAttributesTypeRight
} PSPDF_ENUM_AVAILABLE;

PSPDF_CLASS_AVAILABLE @interface PSPDFThumbnailFlowLayoutAttributes : UICollectionViewLayoutAttributes
@property (nonatomic) PSPDFThumbnailFlowLayoutAttributesType type;
@end

/// A flow layout with support for sticky headers and double-page spreads, as you’d use it for the thumbnails of a magazine.
///
/// @note Although this is a subclass of `UICollectionViewFlowLayout`, a `scrollDirection` of `UICollectionViewScrollDirectionHorizontal` is unsupported.
/// Attempting to set this value will result in unspecified behavior!
PSPDF_CLASS_AVAILABLE @interface PSPDFThumbnailFlowLayout : UICollectionViewFlowLayout

/// @warning This property is inherited, but currently only `UICollectionViewScrollDirectionVertical` is supported.
/// Setting this to `UICollectionViewScrollDirectionHorizontal` will result in unspecified behavior.
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

/// Enables sticky headers. @note Toggling this property invalidates the layout.
@property (nonatomic) BOOL stickyHeaderEnabled;

/// Disables double page mode, when `NO`, it will just follow the `presentationContext`. Defaults to `NO`.
@property (nonatomic) BOOL doublePageModeDisabled;

/// Returns `YES` if the current layout uses double page mode.
@property (nonatomic, readonly) BOOL doublePageMode;

/// We use this object to figure out if we want to use the double page mode and how to use it
@property (nonatomic, weak) id <PSPDFPresentationContext> presentationContext;

/// Returns the attributes type for the specified index path.
- (PSPDFThumbnailFlowLayoutAttributesType)typeForIndexPath:(NSIndexPath *)indexPath usingDoublePageMode:(BOOL)usingDoublePageMode;

/// Returns the index path for the other page in a double page, or `nil` if the type is single.
- (nullable NSIndexPath *)indexPathForDoublePage:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
