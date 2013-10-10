//
//  ObjectArray.h
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "Object.h"

@interface ObjectArray : Object
{
    @protected
    NSMutableDictionary *_data;
}

-(NSInteger)count;

+(ObjectArray*)fromDictionary:(NSDictionary*) dictionary;

-(NSDictionary*)toDictionary;

@end
