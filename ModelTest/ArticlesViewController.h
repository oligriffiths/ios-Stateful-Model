//
//  ArticlesViewController.h
//  ModelTest
//
//  Created by Oli Griffiths on 22/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ViewControllerModel.h"

@interface ArticlesViewController : ViewControllerModel

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)editPushed:(UIBarButtonItem*)sender;
- (IBAction)addPushed:(id)sender;

@end
