//
//  DatabaseStore.h
//  ModelTest
//
//  Created by Oli Griffiths on 09/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "Object.h"
#import <CoreData/CoreData.h>

@interface DatabaseCoreDataStore : Object

@property (nonatomic, readonly) NSManagedObjectModel *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;

@end
