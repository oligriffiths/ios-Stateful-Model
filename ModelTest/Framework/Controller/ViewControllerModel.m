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
    [config append:@{@"model_name": @""}];
    
    [config append:@{
                     @"model": [[ModelCoreData alloc] initWithConfig:[ObjectConfig config:@{@"entity_name": [config get:@"model_name"], @"observers":@[self]}]]
                     }];
    
    [super initialize:config];
}


-(NSManagedObject*)_actionAdd:(CommandContext*)context
{
    NSManagedObject *object = [self.model row];
    
    [object setData:[context get:@"data"]];
    
    [object save];
    
    return object;
}

-(NSManagedObject*)_actionEdit:(CommandContext*)context
{
    NSManagedObject *object = [self.model row];
    
    if(object){
        [object setData:context ? [context get:@"data"] : @{}];
        
        [object save];
    }
    
    return object;
}

-(BOOL)_actionDelete:(CommandContext*)context
{
    NSArray *objects = [context get:@"objects"];
    NSManagedObject *object = [context get:@"object"];
    
    if(!objects && object){
        objects = @[object];
    }

    for(NSManagedObject *object in objects)
    {
        if(![object delete]){
            @throw [NSException exceptionWithName:NSGenericException reason:@"Unable to delete object" userInfo:nil];
        }
    }
    
    return TRUE;
}


@end