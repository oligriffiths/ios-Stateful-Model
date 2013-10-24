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
    return [self initWithConfig:nil];
}

-(id)initWithConfig:(id<ObjectConfigInterface>)config
{
    if(self = [super init]){
        if(config == nil) config = [ObjectConfig new];

        [self construct:config];
    }
    
    return self;
}

-(void)construct:(id<ObjectConfigInterface>)config
{
    [self initialize:config];
    
    _config = config;
}

-(void)initialize:(id<ObjectConfigInterface>)config
{
    
}

@end
