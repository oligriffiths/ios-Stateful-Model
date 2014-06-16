//
//  NSManagedObject+IsNew.h
//  ModelTest
//
//  Created by Oli Griffiths on 16/06/2014.
//  Copyright (c) 2014 Oli Griffiths. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (IsNew)

/*!
 @method isNew
 @abstract   Returns YES if this managed object is new and has not yet been saved yet into the persistent store.
 */
-(BOOL)isNew;

@end
