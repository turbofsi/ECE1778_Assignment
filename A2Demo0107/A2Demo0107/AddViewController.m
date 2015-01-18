//
//  AddViewController.m
//  A2Demo0107
//
//  Created by  吕欣韵 on 2015-01-07.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
//@property (weak, nonatomic) IBOutlet UITextField *txtFood;
@property (weak, nonatomic) IBOutlet UIButton *FoodBtn;
@property (strong, nonatomic) NSArray *FoodArray;
@property (strong, nonatomic) UIPickerView *pView;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _addArray = [[NSMutableArray alloc] init];
    _FoodArray = [[NSArray alloc] initWithObjects:@"Fish",@"Apple",@"Ham",@"Pizza",@"Chicken", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveAction:(UIButton *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [_pView removeFromSuperview];
    
    [self.addArray addObject:_txtName.text];
    [self.addArray addObject:_txtAge.text];
    [self.addArray addObject:_FoodBtn.titleLabel.text];
    
    _txtName.text = nil;
    _txtAge.text = nil;
    [_FoodBtn setTitle:@"Fish" forState:UIControlStateNormal];
    
//    _txtFood.text = nil;
    
//    NSLog(@"%@", _addArray);
}

- (IBAction)foodBtnAction:(UIButton *)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    _pView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 568-216, 0, 0)];
    
    _pView.delegate = self;
    _pView.dataSource = self;
    
    [self.view addSubview:_pView];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 5;
}

#pragma mark - PickerView delegate
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return _FoodArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *temp = _FoodArray[row];
    [_FoodBtn setTitle:temp forState:UIControlStateNormal];
}



@end
