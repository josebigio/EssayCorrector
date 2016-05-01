//
//  PSPDFProcessorSaveOptions.h
//  PSPDFModel
//
//  Copyright (c) 2016 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//

#import <Foundation/Foundation.h>

#import "PSPDFMacros.h"
#import "PSPDFDocumentProvider.h"

@class PSPDFDocument;

NS_ASSUME_NONNULL_BEGIN

PSPDF_CLASS_AVAILABLE @interface PSPDFProcessorSaveOptions : NSObject

/// Returns a `PSPDFProcessorSaveOptions` instance. The source `PSPDFDocument` will be used to infer the security
/// options (like password, permission).
/// @note The password used to unlock the source document will be set for both owner and user password.
+ (PSPDFProcessorSaveOptions*)defaultOptions;

/// Returns a `PSPDFProcessorSaveOptions` instance with owner and user password set.
/// `keyLength` must be divisible by 8 and in the range of 40 to 128.
/// @note This method requires the Document Editor component to be enabled for your license.
+ (instancetype)optionsWithOwnerPassword:(NSString *)ownerPassword userPassword:(NSString *)userPassword keyLength:(NSUInteger)keyLength;

/// Returns a `PSPDFProcessorSaveOptions` instance with owner and user password set.
/// `keyLength` must be divisible by 8 and in the range of 40 to 128.
/// @note This method requires the Document Editor component to be enabled for your license.
+ (instancetype)optionsWithOwnerPassword:(NSString *)ownerPassword userPassword:(NSString *)userPassword keyLength:(NSUInteger)keyLength permissions:(PSPDFDocumentPermissions)documentPermissions;

/// Allows you to set different passwords and on the resulting document.
/// @note This method requires the Document Editor component to be enabled for your license.
- (instancetype)initWithOwnerPassword:(nullable NSString *)ownerPassword userPassword:(nullable NSString *)userPassword keyLength:(nullable NSNumber *)keyLength;

/// Allows you to set different passwords and permissions on the resulting document.
/// @note This method requires the Document Editor component to be enabled for your license.
- (instancetype)initWithOwnerPassword:(nullable NSString *)ownerPassword userPassword:(nullable NSString *)userPassword keyLength:(nullable NSNumber *)keyLength permissions:(PSPDFDocumentPermissions)documentPermissions;

/// The owner password that will be set in the processed Document.
@property (nonatomic, nullable, copy, readonly) NSString *ownerPassword;

/// The user password that will be set in the processed Document.
@property (nonatomic, nullable, copy, readonly) NSString *userPassword;

/// The key-length of the encryption.
@property (nonatomic, nullable, copy, readonly) NSNumber *keyLength;

/// The `PSPDFDocumentPermissions` that will be set.
@property (nonatomic, readonly) PSPDFDocumentPermissions permissions;

@end

NS_ASSUME_NONNULL_END
