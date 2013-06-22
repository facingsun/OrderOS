//
//  HypnosisterSecondViewController.m
//  OrederOS
//
//  Created by Edward on 13-5-8.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "HypnosisterSecondViewController.h"
#import "FPPopoverController.h"
#import "FSCell.h"
#import "OODetailViewController.h"
#import "FSXml.h"
#import "OrderList.h"
#import "DemoTableController.h"

@interface HypnosisterSecondViewController (){
    //UIScrollView *scrollView;
     UISearchBar *searchBar;
    OODetailViewController *detailViewController;
    UIBarButtonItem *menuButton;
    UIView *buttonView;
    FSXml *xmlDataArray;
}
-(void)addOne:(id)sender;
-(void)subOne:(id)sender;
-(IBAction)clickRightButton:(id)sender;

@end

@implementation HypnosisterSecondViewController
@synthesize vegeSearch=_vegeSearch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"菜单", @"Third");
        //[self.tabBarItem setImage:[UIImage imageNamed:@"1_youhui.jpg"]];
        prgeTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-150 )];
        prgeTable.delegate=self;
        prgeTable.dataSource=self;
        [prgeTable setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:prgeTable];
        CGRect rect=CGRectMake(240,0, 80, 44);
        searchBar=[[UISearchBar alloc]initWithFrame:rect];
        //[self.tabBarController.navigationItem.titleView addSubview:searchBar];
        [self.tabBarController.navigationController.view addSubview:searchBar];
        menuButton=[[UIBarButtonItem alloc]initWithTitle:@"菜单" style:UIBarButtonItemStyleBordered target:self action:@selector(clickRightButton:)];
        //[menuButton setBackgroundImage:[UIImage imageNamed:@"beijing.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        self.view.tag=1;
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   // CGRect rect=self.view.bounds;
    //添加scroll，用来添加分类按钮
    /*
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 25)];
    [scrollView setBackgroundColor:[UIColor brownColor]];
    //[scrollView setScrollEnabled:YES];
    scrollView.showsHorizontalScrollIndicator=YES;//设置是否显示滑动条
    scrollView.bounces = YES;//设置是否有滑动过再返回的动画在起始页和最后一页
    [self.view addSubview:scrollView];
     */
    NSString *urlString=@"http://10.48.0.55:8080/allinfo.xml";//url连接
    //FSXml *xmlDataArray=[[FSXml alloc]init];//定义封装号的解析类
    if (!xmlDataArray) {
        xmlDataArray=[[FSXml alloc]init];//定义封装号的解析类
    }
    
    //调用类的初始化函数并将连接发过去，并将数组array传入以获取数据
    NSMutableArray *mutableArray=[NSMutableArray arrayWithCapacity:0];//定义一个可变数组用来放解析的数据
    if (![xmlDataArray initWithURL:urlString XmlDataToArray:mutableArray]) {
        NSLog(@"error");
    }

    allMutableArray=[[NSMutableArray alloc]initWithCapacity:0 ];
    for (int i=0; i<[mutableArray count]; i++) {
        NSDictionary *diction1=[mutableArray objectAtIndex:i];
        diction=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[diction1 objectForKey:@"id"],@"id",[diction1 objectForKey:@"O_name" ],@"O_name",[diction1 objectForKey:@"O_unitprice" ],@"O_unitprice",@"0",@"num",@"0",@"totalSpace", nil];
        [allMutableArray addObject:diction];
    }
    //NSString *string=[NSString stringWithFormat:@"%@",[diction objectForKey:@"num"]];//麻辣豆腐
    //int n;
    //string=[NSString stringWithFormat:@"%d",string.intValue+1 ];
    
    //NSLog(@"string=%@",string);
    
    selectMutableArray=[[NSMutableArray alloc]initWithCapacity:0];
    caitag=0;
    tempMutableArray=allMutableArray;
    _vegeSearch.delegate=self;
    xmlDataArray.delegate=self;
}

-(IBAction)clickRightButton:(id)sender{
    if (!buttonView) {
        buttonView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 580 , 55) ];
    }
     DemoTableController *controller = [[DemoTableController alloc] initWithStyle:UITableViewStylePlain];
    FPPopoverController *popoverController=[[FPPopoverController alloc]initWithViewController:controller];
    [controller release];
    popoverController.tint=FPPopoverDefaultTint;
    popoverController.arrowDirection=FPPopoverArrowDirectionAny;
    [popoverController presentPopoverFromView:buttonView];
    [popoverController release];
    [_vegeSearch resignFirstResponder];
    tempMutableArray=allMutableArray;
    //selectMutableArray=nil;
    [prgeTable reloadData];
}

-(void)addOne:(id)sender{
    UIButton *btn=(UIButton*)sender;
    NSDictionary *dicion=[tempMutableArray objectAtIndex:btn.tag];
    NSString *string=[dicion objectForKey:@"O_unitprice"];
    double singlePrace=string.doubleValue;
    string=[dicion objectForKey:@"num"];
    int num=string.intValue+1;
    double totalPrace=num*singlePrace;
    
    [ dicion setValue:[NSString stringWithFormat:@"%d",num] forKey:@"num"];
    //totolep+=singlePrace;
    
    [dicion setValue:[NSString stringWithFormat:@"%.1lf",totalPrace] forKey:@"totalSpace"];
    [prgeTable reloadData];
    [[OrderList defaultStore] addOrederList:dicion];
    [[OrderList defaultStore]setTotoleValue:singlePrace];
   // NSLog(@"addOne");
    [_vegeSearch resignFirstResponder];
   // NSLog(@"_vegeSearch=%@",_vegeSearch.text);
   
}
-(void)subOne:(id)sender{
    UIButton *btn=(UIButton*)sender;
    NSDictionary *dicion=[tempMutableArray objectAtIndex:btn.tag];
    NSString *string=[dicion objectForKey:@"O_unitprice"];
    double singlePrace=string.doubleValue;
    string=[dicion objectForKey:@"num"];
    int num=string.intValue-1;
    
    double totalPrace=num*singlePrace;
    if (num>0) {
        [ dicion setValue:[NSString stringWithFormat:@"%d",num] forKey:@"num"];
        //totolep-=singlePrace;
        [[OrderList defaultStore]setTotoleValue:-singlePrace];
        [dicion setValue:[NSString stringWithFormat:@"%.1lf",totalPrace] forKey:@"totalSpace"];
        [prgeTable reloadData];
    }else if(num==0)
    {
        //totolep-=singlePrace;
        [[OrderList defaultStore]setTotoleValue:-singlePrace];
        [ dicion setValue:[NSString stringWithFormat:@"%d",num] forKey:@"num"];
         [dicion setValue:@"0" forKey:@"totalSpace"];
        [prgeTable reloadData];
    }else{
        [ dicion setValue:@"0" forKey:@"num"];
    }
    [[OrderList defaultStore] addOrederList:dicion];
    //NSLog(@"subOne");
    [_vegeSearch resignFirstResponder];
  
}

-(void)viewDidUnload{
    [menuButton release];
    [buttonView release];
     [xmlDataArray release];
    [super release];
}

-(void)dealloc{
    //[scrollView release];
    [detailViewController release];
    [prgeTable release];
    [_vegeSearch release];
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.navigationItem setRightBarButtonItem:menuButton];
    [self.tabBarController.navigationItem  setLeftBarButtonItem:nil];
    [self.tabBarController.navigationItem setTitle:@"美味佳肴"];
  // NSLog(@"tabBar=%d",self.tabBarController.tabBar.retainCount);

    NSArray *order=[[OrderList defaultStore] orederListArray];
    int n=0;
    for (int i=0; i<[allMutableArray count]; i++) {
        NSDictionary *orderDic=[allMutableArray objectAtIndex:i];
        for (int j=0; j<[order count]; j++) {
            NSDictionary *allDic=[order objectAtIndex:j];
            if ([[orderDic objectForKey:@"id"] isEqual:[allDic objectForKey:@"id"]]) {
                [orderDic setValue:[allDic objectForKey:@"num"] forKey:@"num"];
                
                [orderDic setValue:[allDic objectForKey:@"totalSpace"] forKey:@"totalSpace"];
                n=1;
                break;
            }
        }
        if (n==0) {
            if (![[orderDic objectForKey:@"num"]isEqual:@"0"]) {
                [orderDic setValue:@"0" forKey:@"num"];
                [orderDic setValue:@"0" forKey:@"totalSpace"];
            }
        }
        n=0;
    }
    [prgeTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"今日优惠    订餐热线：15993161908";
}*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 15;
    return [tempMutableArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    FSCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[[FSCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    for (UIView *view in  cell.contentView.subviews) {
        [view removeFromSuperview];
    }
        NSMutableDictionary *diction1=[tempMutableArray objectAtIndex:indexPath.row];
        
        [cell addCellHeadImageName:@"02.jpg" CGRect:CGRectMake(5, 5, 60, 50)];
        [cell addTextViewText:[NSString stringWithFormat:@"总价：%@￥", [diction1 objectForKey:@"totalSpace" ]] CGRect:CGRectMake(70, 30, 120, 25)];
        [cell addTextViewText:[NSString stringWithFormat:@"单价：%@￥/p", [diction1 objectForKey:@"O_unitprice" ]] CGRect:CGRectMake(70, 10, 95, 25)];
        [cell addTextViewText:[NSString stringWithFormat:@"数量：%@", [diction1 objectForKey:@"num" ]] CGRect:CGRectMake(165, 10, 90, 25)];
        [cell addTitleLabel:[NSString stringWithFormat:@"%@", [diction1 objectForKey:@"O_name" ]] CGRect:CGRectMake(70, 5, 250, 15)];
        UIButton *btn,*btn1;//=[[UIButton alloc]initWithFrame:CGRectMake(275, 5, 40, 15)];
        
        btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setFrame:CGRectMake(255, 3, 60, 25)];
        [btn setTitle:@"order +" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addOne:) forControlEvents:UIControlEventTouchUpInside];
        [cell addCellButton:btn];
        
        btn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn1 setFrame:CGRectMake(255, 32, 60, 25)];
        [btn1 setTitle:@"order -" forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(subOne:) forControlEvents:UIControlEventTouchUpInside];
        [cell addCellButton:btn1];
        btn1.tag=btn.tag=indexPath.row;
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setTag:indexPath.row];
        //cell.textLabel.text=[NSString stringWithFormat:@"%@",[tempMutableArray objectAtIndex:indexPath.row ]];
        [CellIdentifier release];
  
    return cell;
}
#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_vegeSearch resignFirstResponder];
    FSCell *cell=(FSCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        if (detailViewController==nil)
        {
            detailViewController=[[OODetailViewController alloc]init ];
            //NSLog(@"OODetailViewController alloc");
        }
        
        [self.tabBarController.navigationController pushViewController:detailViewController animated:YES];
  
    [cell setSelectionStyle:UITableViewCellAccessoryNone];
}


#pragma mark - UISearchBar view delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSDictionary *diction1;
    for (int i=0; i<[allMutableArray count]; i++) {
        diction1=[allMutableArray objectAtIndex:i];
        if ([_vegeSearch.text isEqualToString:[diction1 objectForKey:@"name"]]) {
            [selectMutableArray addObject:[allMutableArray objectAtIndex:i]];
            //NSLog(@"%@",selectMutableArray);
            //NSLog(@"hello");
        }
    }
    tempMutableArray=selectMutableArray;
   // NSLog(@"tempMutableArray%@",tempMutableArray);
    [prgeTable reloadData];
    //selectMutableArray=nil;
    [_vegeSearch resignFirstResponder];
    //[selectMutableArray removeAllObjects];
    //NSLog(@"%d",[selectMutableArray count]);
    /*for (int i=[selectMutableArray count]-1; i>=0; i--) {
        [selectMutableArray removeObjectAtIndex:i];
    }*/
    //NSLog(@"_vegeSearch=%@",_vegeSearch.text);
}

#pragma mark - XML Delegate

-(void)xmlParserFinished:(NSArray *)array{
    for (int i=0; i<[array count]; i++) {
        NSDictionary *diction1=[array objectAtIndex:i];
        diction=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[diction1 objectForKey:@"id"],@"id",[diction1 objectForKey:@"O_name" ],@"O_name",[diction1 objectForKey:@"O_unitprice" ],@"O_unitprice",@"0",@"num",@"0",@"totalSpace", nil];
        [allMutableArray addObject:diction];
       // NSLog(@"asddfdssdds");
    }
    
    [prgeTable reloadData];
    //NSLog(@"asddfdssdds");
}
@end
