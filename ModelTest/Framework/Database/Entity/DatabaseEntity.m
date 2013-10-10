//
//  DatabaseEntity.m
//  ModelTest
//
//  Created by Oli Griffiths on 09/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "DatabaseEntity.h"

@interface DatabaseEntity ()

@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) DatabaseAdapter *adapter;
@property (nonatomic, readwrite) NSFetchedResultsController *controller;

@end

@implementation DatabaseEntity

-(void)construct:(ObjectConfig *)config
{
    [super construct:config];
    
    //Set the adapter if passed in as a dependency
    if([config get:@"adapter"] && [[config get:@"adapter"] isKindOfClass:[DatabaseAdapter class]]){
        self.adapter = [config get:@"adapter"];
    }
    
    //Set the entity name
    if([config get:@"name"]){
        self.name = [config get:@"name"];
    }
}

-(void)initialize:(ObjectConfig *)config
{
    [config append:@{
                     @"adapter": [NSNull null],
                     @"name": @""
                     }];
    
    [super initialize:config];
}


-(DatabaseAdapter*)adapter
{
    if(!_adapter){
        self.adapter = [DatabaseAdapter new];
    }
    
    return _adapter;
}


-(NSEntityDescription*)entityDescription
{
    NSEntityDescription *description = [NSEntityDescription new];
    [description setName:self.name];
    return description;
}

-(NSFetchRequest*)fetchRequest
{
    NSFetchRequest *request = self.adapter.fetchRequest;
    [request setEntity:self.entityDescription];
    return request;
}

-(id)fetch:(NSFetchRequest*)request
{
    if(self.controller && self.controller.fetchRequest == request){
        return self.controller.fetchedObjects;
    }
    
    self.controller = [self.adapter fetch:request];
    return self.controller.fetchedObjects;
}

-(void)fetch:(NSFetchRequest*)request withBlock:(EntityFetchBlock)block;
{
    id response = [self.adapter fetch:request];
    block(response);
}

-(NSArray*)sections
{
    return self.controller.sections;
}

-(id)objectAtIndexPath:(NSIndexPath*)indexPath
{
    return [self.controller objectAtIndexPath:indexPath];
}

@end
