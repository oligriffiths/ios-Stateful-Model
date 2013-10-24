//
//  DatabaseEntity.h
//  ModelTest
//
//  Created by Oli Griffiths on 09/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "Object.h"
#import "DatabaseAdapter.h"
#import <CoreData/CoreData.h>

typedef void(^EntityFetchBlock)(void (^)(id response));

@interface DatabaseEntity : Object

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) DatabaseAdapter *adapter;
@property (nonatomic, readonly) NSEntityDescription *entityDescription;
@property (nonatomic, readonly) NSFetchedResultsController *controller;
@property (nonatomic, readonly) NSArray *sections;

-(NSFetchRequest*)fetchRequest;

-(id)fetch:(NSFetchRequest*)request;
-(void)fetch:(NSFetchRequest*)request withBlock:(EntityFetchBlock)block;

-(id)objectAtIndexPath:(NSIndexPath*)indexPath;

-(NSManagedObject*)getEntity;

@end
