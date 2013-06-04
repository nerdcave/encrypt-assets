//
//  NSDictionary+Decrypt.m
//  EncryptAssets
//
//  Created by Jay Elaraj.
//  Copyright (c) 2012-2013. All rights reserved.
//
//

#import "NSDictionary+Decrypt.h"

@implementation NSDictionary (Decrypt)

+(NSDictionary*) dictionaryWithContentsOfData:(NSData*)data {
	CFPropertyListRef plist =  CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (CFDataRef)data, kCFPropertyListImmutable, NULL);
	if ([(id)plist isKindOfClass:[NSDictionary class]]) {
		return [(NSDictionary*)plist autorelease];
	} else {
		CFRelease(plist);
		NSString *errorStr = nil;
		NSLog(@"CFPropertyListCreateFromXMLData failed, trying NSPropertyListSerialization...");
		NSPropertyListFormat format;
		NSDictionary* result = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&errorStr];
		NSLog(@"NSPropertyListSerialization success: %d", result != nil);
		return result;
	}
}

@end
