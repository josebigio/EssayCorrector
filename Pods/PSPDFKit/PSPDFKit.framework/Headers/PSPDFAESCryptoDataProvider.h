//
//  PSPDFAESCryptoDataProvider.h
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
#import "PSPDFDataProvider.h"

@class PSPDFAESDecryptor;

NS_ASSUME_NONNULL_BEGIN

/// In the old legacy file format the default number of PBKDF rounds is 50000.
/// The new default is `PSPDFAESDefaultPBKDFNumberOfRounds`. (10000)
PSPDF_EXPORT const NSUInteger PSPDFDefaultPBKDFNumberOfRounds;

/// This class allows a transparent decryption of AES256 encrypted files using
/// the RNCryptor file format https://github.com/rnapier/RNCryptor/wiki/Data-Format
/// Legacy PSPDFKit old file format is also supported.
/// Use the provided encryption tool to prepare your documents.
///
/// Ensure your passphrase/salt are also protected within the binary, or at least obfuscated.
/// Encryption marginally slows down rendering, since everything is decrypted on the fly.
///
/// If saving annotations to a file managed by a `PSPDFAESCryptoDataProvider`, the whole file
/// will be re-written.
///
/// @note The initializers will return nil if the strong encryption feature is not enabled, or if you pass an invalid parameter configuration.
///
/// @note The `passphraseProvider` return parameter should be __nonnull, but we have to wait until Swift compiler rdar://23285766 is resolved by Apple.)
PSPDF_CLASS_AVAILABLE @interface PSPDFAESCryptoDataProvider : NSObject <PSPDFDataProvider>

/// Designated initializer with the passphrase and salt.
/// URL must be a file-based URL.
- (nullable instancetype)initWithURL:(NSURL *)URL passphraseProvider:(NSString *__nullable (^)(void))passphraseProvider salt:(NSString *)salt rounds:(NSUInteger)rounds;

/// Initializer with the passphrase and salt as NSData rather than NSString.
/// URL must be a file-based URL.
- (nullable instancetype)initWithURL:(NSURL *)URL passphraseDataProvider:(NSData *(^)(void))passphraseDataProvider salt:(NSData *)saltData rounds:(NSUInteger)rounds;

/// Designated initializer with the passphrase. Salt will be loaded from the header of the
/// file format (see https://github.com/rnapier/RNCryptor/wiki/Data-Format )
/// The default PRF is kCCPRFHmacAlgSHA1.
/// The number of iterations will be the new default PSPDFAESDefaultPBKDFNumberOfRounds (10000)
/// URL must be a file-based URL.
- (nullable instancetype)initWithURL:(NSURL *)URL passphraseProvider:(NSString *__nullable (^)(void))passphraseProvider;

/// Designated initializer with the passphrase and legacy file format PRF kCCPRFHmacAlgSHA256 and 50000 rounds.
/// Salt will be loaded from the header of the
/// URL must be a file-based URL.
- (nullable instancetype)initWithLegacyFileFormatURL:(NSURL *)URL passphraseProvider:(NSString * __nullable(^)(void))passphraseProvider;

/// Designated initializer with a prepared, stretched, binary key.
/// Warning: only use this if the key is cryptographically random and of length `kCCKeySizeAES256`.
/// The default PRF is `kCCPRFHmacAlgSHA1`.
/// The default number of iterations is `PSPDFAESDefaultPBKDFNumberOfRounds` (10000).
/// For legacy file format use `kCCPRFHmacAlgSHA256` and 50000 rounds.
/// URL must be a file-based URL.
- (nullable instancetype)initWithURL:(NSURL *)URL binaryKeyProvider:(NSData *(^)(void))binaryKeyProvider;

@end

NS_ASSUME_NONNULL_END
