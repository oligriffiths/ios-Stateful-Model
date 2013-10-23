//
//  ModelState.h
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ObjectArray.h"
#import "ModelStateInterface.h"
#import "ModelAbstract.h"

@interface ModelState : ObjectArray <ModelStateInterface>

@end

@protocol StateObserver <NSObject>

-(void)onStateChange:(NSString*)name;

@end

@interface ModelStateValue : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) id filter;
@property (nonatomic) id value;
@property (nonatomic) BOOL unique;
@property (nonatomic) NSArray *required;
@property (nonatomic) id fallback;
@property (nonatomic) NSString* operator;

@end