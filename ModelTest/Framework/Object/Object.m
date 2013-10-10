//
//  Object.m
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "Object.h"

@implementation Object

-(id)init
{
    return [self init:nil];
}

-(id)init:(ObjectConfig *)config
{
    if(self = [super init]){
        if(config == nil) config = [ObjectConfig new];

        [self construct:config];
        
        _config = config;
    }
    
    return self;
}

-(void)construct:(ObjectConfig*)config
{
    [self initialize:config];
}

-(void)initialize:(ObjectConfig*)config
{
    
}

@end
