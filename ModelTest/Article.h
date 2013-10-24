//
//  Article.h
//  ModelTest
//
//  Created by Oli Griffiths on 23/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Article : NSManagedObject

@property (nonatomic) NSString *title;

@property (nonatomic) NSString *summary;

@end
