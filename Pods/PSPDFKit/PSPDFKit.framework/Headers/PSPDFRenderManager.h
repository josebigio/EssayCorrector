//
//  PSPDFRenderManager.h
//  PSPDFKit
//
//  Copyright (c) 2011-2016 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import "PSPDFPlugin.h"

NS_ASSUME_NONNULL_BEGIN

/// The `PSPDFPageInfo` object containing page info.
PSPDF_EXPORT NSString *const PSPDFPageRendererPageInfoKey;

@class PSPDFAnnotation, PSPDFRenderQueue, PSPDFDocumentProvider;

/// Abstract interface for a page renderer.
PSPDF_AVAILABLE_DECL @protocol PSPDFPageRenderer <PSPDFPlugin>

/// Currently `options` contains `PSPDFPageRendererPageInfoKey`.
- (BOOL)drawPage:(NSUInteger)page inContext:(CGContextRef)context documentProvider:(PSPDFDocumentProvider *)documentProvider withOptions:(nullable NSDictionary<NSString *, id> *)options error:(NSError **)error;

@optional

/// Renders annotation appearance streams.
- (BOOL)renderAppearanceStream:(PSPDFAnnotation *)annotation inContext:(CGContextRef)context error:(NSError **)error;

@end

@class PSPDFPageInfo;

typedef NS_OPTIONS(NSUInteger, PSPDFRenderFilter) {
    /// If set, a grayscale filter will be applied.
    PSPDFRenderFilterGrayscale = 1 << 0,
    /// If set and the `PSPDFRenderInvertedKey` key is present, the inverted mode (a.k.a. night mode)
    /// will be rendered color correct.
    PSPDFRenderFilterColorCorrectInverted = 1 << 1,
    /// If set, a sepia filter will be applied.
    PSPDFRenderFilterSepia = 1 << 2
} PSPDF_ENUM_AVAILABLE;

/// Multiplies a color used to color a page.
PSPDF_EXPORT NSString *const PSPDFRenderPageColorKey;

/// Inverts the rendering output. Defaults to `@(NO)`.
PSPDF_EXPORT NSString *const PSPDFRenderInvertedKey;

/// Filters to be applied. Defaults to 0. Filters will increase rendering time.
PSPDF_EXPORT NSString *const PSPDFRenderFiltersKey;

/// Set custom interpolation quality. Defaults to `kCGInterpolationHigh`.
PSPDF_EXPORT NSString *const PSPDFRenderInterpolationQualityKey;

/// Set to YES to NOT draw page content. (Use to just draw an annotation)
PSPDF_EXPORT NSString *const PSPDFRenderSkipPageContentKey;

/// Set to YES to render annotations that have isOverlay = YES set.
PSPDF_EXPORT NSString *const PSPDFRenderOverlayAnnotationsKey;

/// Skip rendering of any annotations that are in this array.
PSPDF_EXPORT NSString *const PSPDFRenderSkipAnnotationArrayKey;

/// If YES, will draw outside of page area.
PSPDF_EXPORT NSString *const PSPDFRenderIgnorePageClipKey;

/// Enabled/Disables antialiasing. Defaults to YES.
PSPDF_EXPORT NSString *const PSPDFRenderAllowAntiAliasingKey;

/// Allows custom render color. Default is white.
PSPDF_EXPORT NSString *const PSPDFRenderBackgroundFillColorKey;

/// Allow custom content rendering after the PDF. `PSPDFRenderDrawBlock`.
PSPDF_EXPORT NSString *const PSPDFRenderDrawBlockKey;

typedef void (^PSPDFRenderDrawBlock)(CGContextRef context, NSUInteger page, CGRect cropBox, NSUInteger rotation, NSDictionary<NSString *, id> *_Nullable options);

/// The PDF render manager coordinates the PDF renderer used.
PSPDF_AVAILABLE_DECL @protocol PSPDFRenderManager <NSObject>

/// Setup the graphics context to the current PDF.
- (void)setupGraphicsContext:(CGContextRef)context rectangle:(CGRect)displayRectangle pageInfo:(PSPDFPageInfo *)pageInfo;

/// The render queue.
@property (nonatomic, readonly) PSPDFRenderQueue *renderQueue;

/// Returns the name of the current PDF renderer.
@property (nonatomic, copy, readonly) NSDictionary<NSString *, id> *rendererInfo;

/// Allows to set a custom renderer.
/// @note PSPDFKit will find custom renderers automatically (classes that implement <PSPDFPageRenderer> and use the one with the highest plugin priority)
/// If this is set to nil, PSPDFKit will fall back to the default core graphics renderer.
@property (atomic, nullable) id<PSPDFPageRenderer> renderer;

@end

NS_ASSUME_NONNULL_END
