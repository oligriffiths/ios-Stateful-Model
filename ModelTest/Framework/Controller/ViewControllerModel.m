//
//  ViewControllerModel.m
//  ModelTest
//
//  Created by Oli Griffiths on 22/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ViewControllerModel.h"

@implementation ViewControllerModel

-(void)construct:(ObjectConfig *)config
{
    [super construct:config];
    
    if([config has:@"model"]){
        self.model = [config get:@"model"];
    }
}

-(void)initialize:(ObjectConfig *)config
{
    [config append:@{
                     @"model_name": @""
                     }];
    
    [config append:@{
                     @"model": [[ModelCoreData alloc] initWithConfig:[ObjectConfig config:@{@"entity_name": [config get:@"model_name"], @"observers":@[self]}]]
                     }];
    
    [super initialize:config];
}


-(void)add
{
    
}


@end
