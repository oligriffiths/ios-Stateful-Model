//
//  CommandContext.m
//  ModelTest
//
//  Created by Oli Griffiths on 23/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "CommandContext.h"

@implementation CommandContext

@synthesize subject;

+(CommandContext*)config:(NSDictionary*)data
{
    return (CommandContext*) [super config:data];
}

-(void)set:(NSString *)name value:(id)value
{
    if([value isKindOfClass:[NSDictionary class]]){
        _data[name] = [ObjectConfig config:value];
    }else{
        [super set:name value:value];
    }
}


@end
