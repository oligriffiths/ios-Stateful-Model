//
//  DatabaseAdapter.m
//  ModelTest
//
//  Created by Oli Griffiths on 09/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "DatabaseAdapter.h"

@interface DatabaseAdapter ()

@property (nonatomic, readwrite) DatabaseCoreDataStore *store;
@property (nonatomic, readwrite) NSManagedObjectContext *context;

@end

@implementation DatabaseAdapter

-(void)construct:(ObjectConfig *)config
{
    [super construct:config];
    
    //Set the store if passed in as a dependency
    if([config get:@"store"] && [[config get:@"store"] isKindOfClass:[DatabaseCoreDataStore class]]){
        self.store = [config get:@"store"];
    }
}

-(void)initialize:(ObjectConfig *)config
{
    [config append:@{
                     @"store": [NSNull null]
                     }];

    [super initialize:config];
}

-(NSManagedObjectContext*)context
{
    if(!_context){
        if (self.store.coordinator != nil) {
            _context = [[NSManagedObjectContext alloc] init];
            [_context setPersistentStoreCoordinator:self.store.coordinator];
        }
    }
    
    return _context;
}

-(DatabaseCoreDataStore*)store
{
    if(!_store){
        self.store = [DatabaseCoreDataStore new];
    }
    
    return _store;
}

-(NSFetchRequest*)fetchRequest
{
    NSFetchRequest *request = [NSFetchRequest new];
    request.sortDescriptors = @[];
    return request;
}

-(NSFetchedResultsController*)fetch:(NSFetchRequest*)request
{
    return [self fetch:request withSectionKeyPath:Nil andCacheName:nil];
}

-(NSFetchedResultsController*)fetch:(NSFetchRequest*)request withSectionKeyPath:(NSString*) sectionKeyPath andCacheName:(NSString*)cacheName
{
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.context sectionNameKeyPath:sectionKeyPath cacheName:cacheName];
    fetchedResultsController.delegate = self;

    //Perform the request
    NSError *error;
    [fetchedResultsController performFetch:&error];
    
    NSAssert(!error, @"Error performing fetch request: %@", error);
    
    return fetchedResultsController;
}

@end
