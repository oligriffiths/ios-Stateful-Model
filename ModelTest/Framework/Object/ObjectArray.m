//
//  ObjectArray.m
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ObjectArray.h"
#import "ObjectConfig.h"

@implementation ObjectArray

-(void)construct:(ObjectConfig *)config
{
    [super construct:config];
    
    _data =  [NSMutableDictionary dictionaryWithDictionary:[config get:@"data"]];
}

-(void)initialize:(ObjectConfig *)config
{
    [config append:@{
                     @"data": [NSMutableDictionary new]
                     }];
    [super initialize:config];
}

-(NSInteger)count
{
    return _data.count;
}

+(ObjectArray*)fromDictionary:(NSDictionary*) dictionary
{
    ObjectConfig *config = [ObjectConfig config:@{@"data":dictionary}];
    return [[ObjectArray alloc] initWithConfig: config];
}

-(NSDictionary*)toDictionary
{
    return [NSDictionary dictionaryWithDictionary:_data];
}

@end
