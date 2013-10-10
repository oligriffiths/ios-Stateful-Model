//
//  DatabaseAdapter.h
//  ModelTest
//
//  Created by Oli Griffiths on 09/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "Object.h"
#import "DatabaseCoreDataStore.h"

@interface DatabaseAdapter : Object <NSFetchedResultsControllerDelegate>

@property (nonatomic, readonly) DatabaseCoreDataStore *store;
@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSFetchRequest *fetchRequest;

-(NSFetchedResultsController*)fetch:(NSFetchRequest*)request;
-(NSFetchedResultsController*)fetch:(NSFetchRequest*)request withSectionKeyPath:(NSString*) sectionKeyPath andCacheName:(NSString*)cacheName;

@end
