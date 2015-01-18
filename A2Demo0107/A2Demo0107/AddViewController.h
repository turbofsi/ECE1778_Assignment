//
//  AddViewController.h
//  A2Demo0107
//
//  Created by  吕欣韵 on 2015-01-07.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSMutableArray *addArray;

- (IBAction)saveAction:(UIButton *)sender;
- (IBAction)foodBtnAction:(UIButton *)sender;

@end
