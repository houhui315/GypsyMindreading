//
//  ViewController.m
//  GypsyMindreading
//
//  Created by hou hui on 2018/10/22.
//  Copyright © 2018 hou hui. All rights reserved.
//

#import "ViewController.h"

#define ScreenSize [[UIScreen mainScreen] bounds].size

@interface ViewController (){
    
    UIScrollView *myScollView;
    NSInteger dataArray[100]; //数据集合
    NSDictionary *dicAry;
    UILabel *contetLabel;
    NSInteger defaultNum;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"读心术";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查看" style:UIBarButtonItemStylePlain target:self action:@selector(lookResult:)];
    
    [self initData];
    [self initUI];
    [self initPages];
}

-(void)initUI{
    
    contetLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenSize.width - 20, 30)];
    contetLabel.text = @"“吉普赛人祖传的神奇读心术.它能测算出你的内心感应”\n提示：任意选择一个两位数（或者说，从10~99之间任意选择一个数），把 这个数的十位与个位相加，再把任意选择的数减去这个和。例如：你选的数是23，然后2+3=5，然后23- 5=18\n在图表中找出与最后得出的数所相应的图形，并把这个图形牢记心中，然后点击水晶球。你会发 现，水晶球所显示出来的图形就是你刚刚心里记下的那个图形。";
    contetLabel.numberOfLines = 0;
    
    CGSize contetZize = [contetLabel.text sizeWithFont:contetLabel.font constrainedToSize:CGSizeMake(contetLabel.bounds.size.width, NSIntegerMax)];
    [contetLabel setFrame:CGRectMake(10, 10, ScreenSize.width - 20, contetZize.height)];
    myScollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
    [myScollView addSubview:contetLabel];
    myScollView.userInteractionEnabled = YES;
    
    [self.view addSubview:myScollView];
    
}

-(void)initPages{
    
    //删除原来的
    for (NSInteger i = 0; i < 5; i ++) {
        UIView *subview = [myScollView viewWithTag:i+1];
        [subview removeFromSuperview];
    }
    //重新创建
    NSInteger labelWidth = ScreenSize.width/5;
    CGFloat dataHeight = 0.f;
    for (NSInteger i = 0; i < 5; i ++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth*i, CGRectGetMaxY(contetLabel.frame)+10, labelWidth, 100)];
        label.font = [UIFont systemFontOfSize:25.f];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [myScollView addSubview:label];
        label.tag = i+1;
        
        NSString *text = [[NSString alloc] init];
        for (NSInteger j = 0; j < 20; j++) {
            
            NSInteger num = i*20+j;
            NSString *enmgy = dicAry[[NSString stringWithFormat:@"%ld",dataArray[num]]];
            text = [text stringByAppendingFormat:@"%ld:%@\n",num,enmgy];
        }
        label.text = text;
        
        CGSize size = [text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, NSIntegerMax)];
        [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, size.height)];
        
        dataHeight = CGRectGetMaxY(label.frame);
    }
    [myScollView setContentSize:CGSizeMake(ScreenSize.width, dataHeight)];
}

-(void)initData{
    
    dicAry = @{@"0": @"ଅ",
               @"1": @"ଆ",
               @"2": @"ଇ",
               @"3": @"ଈ",
               @"4": @"ଉ",
               @"5": @"ଊ",
               @"6": @"ଋ",
               @"7": @"ଌ",
               @"8": @"ଏ",
               @"9": @"ଐ",
               @"10": @"ଓ",
               @"11": @"ଗ",
               @"12": @"ଙ",
               @"13": @"ଧ",
               @"14": @"ଫ",
               @"15": @"ଭ",
               @"16": @"ଯ",
               @"17": @"ର",
               @"18": @"ଳ",
               @"19": @"ହୖ",};
    
    defaultNum =  arc4random() % 20;
    
    for (NSInteger i = 0; i < 100; i ++) {
        
        if (i>=9 && i<=81 && i%9 == 0) { //固定一样的值
            
            dataArray[i] = defaultNum;
        }else{
            dataArray[i] = arc4random() % 20;
        }
    }
}

-(void)lookResult:(id)sender{
    
    NSString *text = dicAry[[NSString stringWithFormat:@"%ld",defaultNum]];
    NSString *message = [NSString stringWithFormat:@"你的选择是:%@",text];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"再来一次", nil];
    [alert show];
}

-(void)replay{
    
    [self initData];
    [self initPages];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self replay];
}


@end
