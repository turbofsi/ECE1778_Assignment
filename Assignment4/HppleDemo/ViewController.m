//
//  ViewController.m
//  HppleDemo
//
//  Created by Vytautas Galaunia on 11/25/14.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//- (NSData *) toUTF8:(NSData *)sourceData{
//    CFStringRef gbkStr = CFStringCreateWithBytes(NULL, [sourceData bytes], [sourceData length], kCFStringEncodingGB_18030_2000, false);
//    
//    if (gbkStr == nil) {
//        return nil;
//    }
//    
//    else{
//        NSString *gbkString = (__bridge NSString *)gbkStr;
////
//
//    }
//    
//    
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadAction:(UIButton *)sender {
    [self performSelectorInBackground:@selector(loadToDataBase) withObject:nil];
}

#pragma mark - multithread
- (void)loadToDataBase {
    NSString *urlString = @"http://www.eecg.utoronto.ca/~jayar/PeopleList";
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];
    
    CFStringRef gbkStr = CFStringCreateWithBytes(NULL, [htmlData bytes], [htmlData length], kCFStringEncodingGB_18030_2000, false);
    
    NSString *gbHtmlStr = (__bridge NSString *)gbkStr;
    NSString *utf8HtmlStr = [gbHtmlStr stringByReplacingOccurrencesOfString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\">" withString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"];
    
    NSData *htmlDataUTF8 = [utf8HtmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    TFHpple *xpathparser = [[TFHpple alloc] initWithHTMLData:htmlDataUTF8];
    
    NSArray *array = [xpathparser searchWithXPathQuery:@"//p"];
    TFHppleElement *element = array[0];
    NSString *tag = [element content];
    
    NSMutableArray *nameArray = [[NSMutableArray alloc] init];
    NSMutableArray *positionArray = [[NSMutableArray alloc] init];
    [positionArray addObject:@"0"];
    
    for (int i = 0; i < [tag length]; i++) {
        int index = [tag characterAtIndex:i];
        if (index == 10) {
//            NSLog(@"enter position: %d", i);
            [positionArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    
//    NSLog(@"%@", positionArray);
    
    for (int j=0; j < [positionArray count] - 2; j++) {
        int s1 = [positionArray[j] intValue];
        int s2 = [positionArray[j+1] intValue];
        if (s1 == 0) {
            NSString *tempName = [tag substringWithRange:NSMakeRange(s1, s2-s1)];
            [nameArray addObject:tempName];
        } else{
            NSString *tempName = [tag substringWithRange:NSMakeRange(s1+1, s2-s1-1)];
            [nameArray addObject:tempName];
        }
    }
    
    [self performSelectorOnMainThread:@selector(finishAction:) withObject:nameArray waitUntilDone:YES];
    
    

}


- (void)finishAction:(NSMutableArray *)array {
    _loadArray = array;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mission complete" message:@"completed" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Confirm", nil];
    [alert show];
    NSLog(@"%@", _loadArray);
}





@end
