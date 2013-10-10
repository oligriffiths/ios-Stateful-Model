//
//  BaseViewController.m
//  AIG CyberEdge
//
//  Created by Oli on 08/08/2013.
//  Copyright (c) 2013 Oli. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

-(id)init
{
    if(self = [super init]) [self initialize];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) [self initialize];
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) [self initialize];
    return self;
}

-(void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(localize)
                                                 name:NSCurrentLocaleDidChangeNotification
                                               object:nil];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self localize];
}

-(void)localize
{
    
}

@end
