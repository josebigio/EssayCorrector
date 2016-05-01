//
//  PSPDFAnnotationCell.h
//  PSPDFKit
//
//  Copyright (c) 2013-2016 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "PSPDFTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class PSPDFAnnotation;

/// Displays information about an annotation.
PSPDF_CLASS_AVAILABLE @interface PSPDFAnnotationCell : PSPDFNonAnimatingTableViewCell

/// Calculates the size.
+ (CGFloat)heightForAnnotation:(PSPDFAnnotation *)annotation constrainedToSize:(CGSize)constrainedToSize;

/// The annotation that will be displayed.
@property (nonatomic, nullable) PSPDFAnnotation *annotation;

@end

@interface PSPDFAnnotationCell (SubclassingHooks)

/// Builds the string for the `detailTextLabel`.
+ (NSString *)dateAndUserStringForAnnotation:(PSPDFAnnotation *)annotation;

@end

NS_ASSUME_NONNULL_END
