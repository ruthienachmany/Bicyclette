//
//  NSStringAdditions.m
//  Bicyclette
//
//  Created by Nicolas Bouilleaud on 29/06/07.
//  Copyright 2007 Nicolas Bouilleaud.
//

#import "NSStringAdditions.h"


@implementation NSString (NSStringAdditions)


- (NSString*) stringByDeletingPrefix:(NSString*) prefix
{
	if( ![self hasPrefix:prefix] )
		return self;
	return [self substringFromIndex:[prefix length]];
}

- (NSString*) stringStartingAtComponent:(NSUInteger)start usingSeparator:(NSString*)separator
{
    NSArray * components = [self componentsSeparatedByString:separator];
    if([components count]<=start)
        return @"";
    else
        return [[components subarrayWithRange:NSMakeRange(start, [components count]-start)] componentsJoinedByString:separator];
}

- (NSString*) stringByTrimmingZeros
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]];
}

- (NSString*) stringByTrimmingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString*) stringByTrimmingQuotes
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"'\""]];
}

- (NSString*) capitalizedStringWithCurrentLocale
{
    return [self capitalizedStringWithLocale:[NSLocale currentLocale]];
}

@end
