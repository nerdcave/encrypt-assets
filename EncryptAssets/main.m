//
//  main.m
//  EncryptAssets
//
//  Created by Jay Elaraj.
//  Copyright (c) 2012-2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+AES256.h"

/*
 usage:

 EncryptAssets /path/to/folder/with/assets/ /path/to/destination/folder/for/encrypted/assets/ some_$3cr3t_key
*/

int main (int argc, const char *argv[]) {

	@autoreleasepool {

		NSString *assetPath = [NSString stringWithUTF8String:argv[1]];
		NSString *destinationPath = [NSString stringWithUTF8String:argv[2]];
		NSString *key = [NSString stringWithUTF8String:argv[3]];
		NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
		
	    NSFileManager *fileManager = [NSFileManager defaultManager];
		NSURL *directoryURL = [NSURL URLWithString:assetPath];
		NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
		
		NSDirectoryEnumerator *enumerator = [fileManager
											 enumeratorAtURL:directoryURL
											 includingPropertiesForKeys:keys
											 options:0
											 errorHandler:^(NSURL *url, NSError *error) {
												 NSLog(@"NSDirectoryEnumerator Error: %@", [error localizedFailureReason]);
												 return YES;
											 }];
		
		for (NSURL *url in enumerator) { 
			NSError *error;

			NSNumber *isHidden = nil;
			[url getResourceValue:&isHidden forKey:NSURLIsHiddenKey error:&error];
			if ([isHidden boolValue]) continue;

			NSNumber *isDirectory = nil;
			if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
				NSLog(@"getResourceValue Error: %@", [error localizedFailureReason]);
			}
			if ([isDirectory boolValue]) {
				//NSLog(@"DIRECTORY: %@", [url relativePath]);
			} else {
				NSString* filename = [url relativePath];
				//NSLog(@"FILE: %@", filename);
				NSData *data = [NSData dataWithContentsOfFile:filename];
				NSData* fileData = [data encryptedWithKey:keyData];

				NSRange assetPathRange = [filename rangeOfString:assetPath];
				
				NSString* part = [filename substringFromIndex:assetPathRange.location + assetPathRange.length];
				NSString* destinationFilePath = [destinationPath stringByAppendingString:part];
				NSString* destinationPath = [destinationFilePath stringByDeletingLastPathComponent];
				//NSLog(@"destination: %@ %@", destinationFilePath, destinationPath);
				
				[fileManager createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error:nil];

				if ([fileData writeToFile:destinationFilePath atomically:YES]) {
					NSLog(@"SUCCESS: %@", filename);
				} else {
					NSLog(@"FAILED: %@", filename);
				}
			}
			
		}
	}
    return 0;
}
