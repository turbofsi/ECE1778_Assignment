//
//  LoadViewController.h
//  A2Demo0107
//
//  Created by  吕欣韵 on 2015-01-08.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoadViewController;

@protocol LoadViewDelegate <NSObject>

-(void)LoadDataViewController:(LoadViewController *)controller didFinishLoadData:(NSMutableArray *)loadedArray;

@end


@interface LoadViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <LoadViewDelegate> delegate;
@property (strong, nonatomic) NSArray *loadDocArray;

@end
