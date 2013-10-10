//
//  MasterViewController.h
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>
#import "ArticlesModel.h"

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate,ModelStateObserver>

@property (nonatomic) ModelCoreData *model;

- (IBAction)sortChanged:(id)sender;

@end
