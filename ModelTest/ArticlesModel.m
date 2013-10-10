//
//  ArticlesModel.m
//  ModelTest
//
//  Created by Oli Griffiths on 09/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ArticlesModel.h"

@implementation ArticlesModel

-(void)construct:(ObjectConfig *)config
{
    [super construct:config];
    
    [self.state setValue:@"title" forState:@"sort"];    
}

-(void)initialize:(ObjectConfig *)config
{
    [config append:@{@"entity_name": @"Article"}];
    [super initialize:config];
}

@end
