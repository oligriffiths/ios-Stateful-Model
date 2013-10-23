//
//  DatabaseStore.m
//  ModelTest
//
//  Created by Oli Griffiths on 09/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "DatabaseCoreDataStore.h"

@interface DatabaseCoreDataStore ()

@property (nonatomic, readwrite) NSManagedObjectModel *model;
@property (nonatomic, readwrite) NSPersistentStoreCoordinator *coordinator;

@end


@implementation DatabaseCoreDataStore

-(id)initWithConfig:(ObjectConfig *)config
{
    self = [super initWithConfig:config];
    
    //Set the model if passed in as a dependency
    if([config get:@"model"] && [[config get:@"model"] isKindOfClass:[NSManagedObjectModel class]]){
        self.model = [config get:@"model"];
    }
    
    //Set the coordinator if passed in as a dependency
    if([config get:@"coordinator"] && [[config get:@"coordinator"] isKindOfClass:[NSPersistentStoreCoordinator class]]){
        self.coordinator = [config get:@"coordinator"];
    }
    
    return self;
}

-(void)initialize:(ObjectConfig *)config
{
    [config append:@{
                     @"model": [[NSUserDefaults standardUserDefaults] objectForKey:@"DataModelName"] ?: @"DataModel",
                     @"extension": @"momd",
                     @"db_directory": [[NSUserDefaults standardUserDefaults] objectForKey:@"DatabaseDirectory"] ?: [self _applicationDocumentsDirectory],
                     @"db_name": [[NSUserDefaults standardUserDefaults] objectForKey:@"DatabaseName"] ?: @"Database.sqllite"
                     }];
    
    [super initialize:config];
}

-(NSManagedObjectModel*)model
{
    if(!_model)
    {
        NSString *name = [self.config get:@"model"];
        NSString *extension = [self.config get:@"extension"];
        self.model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:name withExtension:extension]];
    }
    
    return _model;
}

-(NSPersistentStoreCoordinator*)coordinator
{
    if(!_coordinator)
    {
        NSError *error = nil;
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self _databaseURL] options:nil error:&error];
        
        //@TODO: Handle error
    }
    
    return _coordinator;
}

//Generates the database path url
-(NSURL*)_databaseURL
{
    return [(NSURL*)[self.config get:@"db_directory"] URLByAppendingPathComponent:[self.config get:@"db_name"]];
}

// Returns the URL to the application's Documents directory.
- (NSURL *)_applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
