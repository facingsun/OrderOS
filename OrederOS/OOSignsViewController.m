//
//  OOSignsViewController.m
//  OrederOS
//
//  Created by Edward on 13-5-8.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "OOSignsViewController.h"
#import "OODetailViewController.h"
//#import "SPScrollViewPaging.h"

@interface OOSignsViewController (){
    NSMutableArray *btnArray;
    UIScrollView *scrollView;
    OODetailViewController *detailViewController;
}
-(void)clickSignsButton:(id)sender;
-(void)creatButton;

@end

@implementation OOSignsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //signsView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.view setBackgroundColor:[UIColor brownColor]];
        
        signArray=[[NSMutableArray alloc]initWithObjects:@"1_youhui.jpg",@"2_youhui.jpg",@"3_youhui.jpg",@"4_youhui.jpg",@"5_youhui.jpg",@"6_youhui.jpg",@"7_youhui.jpg",@"8_youhui.jpg",@"1_youhui.jpg",@"2_youhui.jpg",@"3_youhui.jpg",@"5_youhui.jpg",@"6_youhui.jpg",@"7_youhui.jpg", nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:@"我们的招牌"];
    
    [self creatButton];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    /*for (int i=0;i<[btnArray count]; i++) {
        [[btnArray objectAtIndex:i] release];
    }*/
    [btnArray release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect rect=self.view.bounds;
    rect.origin.y=0;
    UILabel *orderPhoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 10)];
    [orderPhoneLabel setFont:[UIFont systemFontOfSize:10]];
    [orderPhoneLabel setTextAlignment:NSTextAlignmentRight];
    [orderPhoneLabel setText:@" 订餐热线：15993161900 "];
    [orderPhoneLabel setBackgroundColor:[UIColor clearColor]];
        
    scrollView=[[UIScrollView alloc]initWithFrame:rect];
    [scrollView setBackgroundColor:[UIColor brownColor]];
    //[scrollView setScrollEnabled:YES];
    scrollView.showsHorizontalScrollIndicator=YES;//设置是否显示滑动条
    scrollView.bounces = YES;//设置是否有滑动过再返回的动画在起始页和最后一页
    [self.view addSubview:scrollView];
    [self.view addSubview:orderPhoneLabel];
    [orderPhoneLabel release];

    
}

-(void)viewDidUnload{
 
    [scrollView release];
    [detailViewController release];
    [super release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)creatButton{
    
    int h;
    CGRect rect;
    int i;
    for (i=0; i<[signArray count]; i++) {
        h=i/2*110;
        
        if (i%2==0) {
            rect=CGRectMake(0, h, 159, 111);
        }
        else{
            rect=CGRectMake(161, h, 159, 111);
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setFrame:rect];
        [btn setBackgroundImage:[UIImage imageNamed:[signArray objectAtIndex:i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickSignsButton:) forControlEvents:UIControlEventTouchUpInside];
        [btnArray addObject:btn];
        [scrollView addSubview:btn];
        
    }
    rect.size.height=(i+3)/2*111+10;
    rect.size.width=self.view.frame.size.width;
    [scrollView setContentSize:rect.size];
}



-(void)clickSignsButton:(id)sender{
    //NSLog(@"clickSignsButton");
    if (detailViewController==nil)
    {
        detailViewController=[[OODetailViewController alloc]init ];
       
        //NSLog(@"OODetailViewController alloc");
    }
    detailViewController.navigationItem.title=@"详细信息";
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
