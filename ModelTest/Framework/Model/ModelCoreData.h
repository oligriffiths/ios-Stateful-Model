//
//  ModelData.h
//  ModelTest
//
//  Created by Oli Griffiths on 08/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ModelAbstract.h"
#import "DatabaseEntity.h"

@interface ModelCoreData : ModelAbstract

@property (nonatomic, readonly) DatabaseEntity *entity;
@property (nonatomic, readonly) NSArray* sections;

-(id)objectAtIndexPath:(NSIndexPath*)indexPath;

-(void)_buildRequestProperties:(NSFetchRequest*)request;

-(void)_buildRequestEntity:(NSFetchRequest*)request;

-(void)_buildRequestConditions:(NSFetchRequest*)request;

-(void)_buildRequestOrder:(NSFetchRequest*)request;

-(void)_buildRequestLimit:(NSFetchRequest*)request;

@end
