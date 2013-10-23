//
//  ViewControllerModel.h
//  ModelTest
//
//  Created by Oli Griffiths on 22/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ViewControllerAbstract.h"

@interface ViewControllerModel : ViewControllerAbstract

@property (nonatomic) id<ModelInterface> model;

@end
