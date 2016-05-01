//
//  PSPDFDataSink.h
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

NS_ASSUME_NONNULL_BEGIN

/// Specifies the type of `PSPDFDataSink` you're requesting.
typedef NS_OPTIONS(NSUInteger, PSPDFDataSinkOptions) {
    /// No option specified, the returned `PSPDFDataSink` is completely empty and writing starts at the beginning.
    PSPDFDataSinkOptionNone     = 0,

    /// Append mode. The `PSPDFDataProviders` data will be used as a starting point and writing starts at the end.
    PSPDFDataSinkOptionAppend   = 0x01
};

/// This protocol allows `PSPDFDataProvider` to return a object that can be used to re-write/append to a data source.
PSPDF_AVAILABLE_DECL @protocol PSPDFDataSink <NSObject>

/// Checks if `finish` has been called.
@property (nonatomic, readonly) BOOL isFinished;

/// Writes data sequentially to the data source. If it returns NO, no further operations should be attempted on
/// this `PSPDFDataSink`.
- (BOOL)writeData:(NSData *)data;

/// Call this when you're done writing to the `PSPDFDataSink`. Some `PSPDFDataSink` might need to execute
/// a couple of operations after writing is done (e.g. finishing up encryption).
- (BOOL)finish;

@end

NS_ASSUME_NONNULL_END
