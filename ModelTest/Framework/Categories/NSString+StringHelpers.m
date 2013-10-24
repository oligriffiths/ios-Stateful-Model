//
//  NSString+(StringHelpers).m
//  ModelTest
//
//  Created by Oli Griffiths on 23/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "NSString+StringHelpers.h"

@implementation NSString (StringHelpers)

-(NSString*)lowercaseFirst
{
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] lowercaseString]];
}


-(NSString*)uppercaseFirst
{
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] uppercaseString]];
}

@end
