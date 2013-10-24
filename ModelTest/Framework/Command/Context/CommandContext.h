//
//  CommandContext.h
//  ModelTest
//
//  Created by Oli Griffiths on 23/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ObjectConfig.h"

@protocol CommandContextInterface

@property (nonatomic) id subject;

@end



@interface CommandContext : ObjectConfig <CommandContextInterface>

+(CommandContext*)config:(NSDictionary*)data;

@end
