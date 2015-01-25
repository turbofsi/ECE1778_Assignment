//
//  DetailViewController.h
//  ActionCameraDemo
//
//  Created by  吕欣韵 on 2015-01-23.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+fixOrientation.h"

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *currentArray;
@property (strong, nonatomic) NSMutableArray *localArray;

@end
