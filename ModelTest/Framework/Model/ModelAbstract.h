//
//  ModelAbstract.h
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "Object.h"
#import "ModelInterface.h"
#import "ModelState.h"

@interface ModelAbstract : Object <ModelInterface>

@property (nonatomic, readonly, setter=none:) id<ModelStateInterface> state;
@property (nonatomic) NSManagedObject *row;
@property (nonatomic) NSArray *rowset;
@property (nonatomic, readonly) NSInteger total;
@property (nonatomic, readonly) NSArray *sections;

@end