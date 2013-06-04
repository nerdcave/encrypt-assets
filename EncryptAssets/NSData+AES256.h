//
//  NSData+AES256.h
//  EncryptAssets
//
//  Created by Jay Elaraj.
//  Copyright (c) 2012-2013. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES256)

-(NSData*) encryptedWithKey:(NSData*)key;
-(NSData*) decryptedWithKey:(NSData*)key;

@end