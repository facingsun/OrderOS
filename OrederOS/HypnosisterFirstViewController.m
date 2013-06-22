//
//  HypnosisterFirstViewController.m
//  OrederOS
//
//  Created by Edward on 13-5-8.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "HypnosisterFirstViewController.h"
#import "EGOImageView.h"
#import "SPScrollViewPaging.h"
#import "FSCell.h"
#import "OOSignsViewController.h"
#import "OODetailViewController.h"
#import "OrderList.h"


@interface HypnosisterFirstViewController (){
    UIBarButtonItem *createMenuNum;
    UIBarButtonItem *ourSigns;
    OOSignsViewController *signController;
    OODetailViewController *detailViewController;
    FSXml *xmlDataArray;
}

-(void)clickLeftButton:(id)sender;
-(void)clickRightButton:(id)sender;

@end

@implementation HypnosisterFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"食谱", @"食谱");
        self.tabBarItem.image = [UIImage imageNamed:@"gouwuche.png"];
//        [self.tabBarItem setImage:[UIImage imageNamed:@"gouwuche.png"]];
        createMenuNum=[[UIBarButtonItem alloc]initWithTitle:@"创建菜单编号" style:UIBarButtonItemStyleBordered target:self action:@selector(clickRightButton:)];
        
         ourSigns=[[UIBarButtonItem alloc]initWithTitle:@"招牌食物" style:UIBarButtonItemStyleBordered target:self action:@selector(clickLeftButton:)];
        //[ourSigns setBackgroundImage:[UIImage imageNamed:@"tese.jpg"] forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
        
        prgeTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-212 )];
        [prgeTable setBackgroundColor:[UIColor clearColor]];
        prgeTable.delegate=self;
        prgeTable.dataSource=self;
        [self.view addSubview:prgeTable];
        self.view.tag=0;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.navigationItem setRightBarButtonItem:createMenuNum];
    [self.tabBarController.navigationItem  setLeftBarButtonItem:ourSigns];
    [self.tabBarController.navigationItem setTitle:@"食    谱"];
    //self.tabBarController.tabBar.retainCount
    //NSLog(@"table:%d",self.tabBarController.viewControllers.retainCount);
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

- (void)viewDidLoad
{
   
    [super viewDidLoad];
    [self adScrollView];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *urlString=@"http://10.48.0.55:8080/allinfo.xml";//url连接
    if (!xmlDataArray) {
        xmlDataArray=[[FSXml alloc]init];//定义封装号的解析类
    }
    
    //调用类的初始化函数并将连接发过去，并将数组array传入以获取数据
    NSMutableArray *mutableArray=[NSMutableArray arrayWithCapacity:0];//定义一个可变数组用来放解析的数据
    if (![xmlDataArray initWithURL:urlString XmlDataToArray:mutableArray]) {
        NSLog(@"error");
    }
    
    allMutableArray=[[NSMutableArray alloc]initWithCapacity:1];
    
    for (int i=0; i<[mutableArray count]; i++) {
        NSDictionary *diction1=[mutableArray objectAtIndex:i];
        diction=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[diction1 objectForKey:@"id"],@"id",[diction1 objectForKey:@"O_name" ],@"O_name",[diction1 objectForKey:@"O_unitprice" ],@"O_unitprice",@"0",@"num",@"0",@"totalSpace", nil];
        [allMutableArray addObject:diction];
    }
    xmlDataArray.delegate=self;
  
    caitag=0;
}
-(void)viewDidUnload{
    
    [ourSigns release];
   // [moreSelect release];
    [detailViewController release];
    [prgeTable release];
      [xmlDataArray release];
    [super release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)adScrollView
{
    if(ADArray!=nil)
    {
        [ADArray release];
    }
    ADArray=[[NSArray alloc]initWithObjects:@"01.png",@"02.jpg",@"03.jpg",@"04.jpg", nil];
    SPScrollViewPaging *scrollView=[[SPScrollViewPaging alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    
    NSMutableArray *views=[[NSMutableArray alloc]init];
    for (int i=0; i<[ADArray count]; i++)
    {
        // NSDictionary *adDiction=[ADArray objectAtIndex:i];
        // NSString *adUrl=[NSString stringWithFormat:@"%@%@",GETIMAGE,[adDiction objectForKey:@"poster"]];
        //adUrl=[adUrl stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];//需要转码，如果不转码有可能获取不到数据
        adImageView=[[EGOImageView alloc]initWithPlaceholderImage:[ UIImage imageNamed:[ADArray objectAtIndex:i]]];
        [views addObject:adImageView];
        // adImageView.imageURL=[NSURL URLWithString:adUrl];
        [adImageView release];
    }
    
    [scrollView addPages:views];
    [self.view addSubview:scrollView];
    [scrollView setHasPageControl:YES];
    [ADArray release];
    [views release];
    [scrollView release];
    
}

-(void)clickRightButton:(id)sender{
    if ([createMenuNum.title isEqualToString:[NSString stringWithFormat:@"创建菜单编号"]]) {
        [createMenuNum setTitle:@"您的单号是12"];
        [createMenuNum setEnabled:NO];//创建单号以后将不可以更改，这里暂时将按钮点击属性关闭
    }else
    {
        [createMenuNum setTitle:@"创建菜单编号"];
    }
    
    //NSLog(@"clickRightButton");
}
-(void)clickLeftButton:(id)sender{
    if (!signController) {
         signController=[[OOSignsViewController alloc]initWithNibName:@"OOSignsViewController" bundle:nil];
    }
    [self.tabBarController.navigationController pushViewController:signController animated:YES];
}

-(void)addOne:(id)sender{
    UIButton *btn=(UIButton*)sender;
    NSDictionary *dicion=[allMutableArray objectAtIndex:btn.tag];
    NSString *string=[dicion objectForKey:@"O_unitprice"];
    double singlePrace=string.doubleValue;
    string=[dicion objectForKey:@"num"];
    int num=string.intValue+1;
    double totalPrace=num*singlePrace;
    //NSLog(@"totalPrace:%lf",totalPrace);
    [ dicion setValue:[NSString stringWithFormat:@"%d",num] forKey:@"num"];
    //totolep+=singlePrace;
    
    [dicion setValue:[NSString stringWithFormat:@"%.1lf",totalPrace] forKey:@"totalSpace"];
    [prgeTable reloadData];
    [[OrderList defaultStore] addOrederList:dicion];
    [[OrderList defaultStore]setTotoleValue:singlePrace];

}
-(void)subOne:(id)sender{
    UIButton *btn=(UIButton*)sender;
    NSDictionary *dicion=[allMutableArray objectAtIndex:btn.tag];
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
        //singlePrace-=singlePrace;
        [[OrderList defaultStore]setTotoleValue:-singlePrace];
        [ dicion setValue:[NSString stringWithFormat:@"%d",num] forKey:@"num"];
        [dicion setValue:@"0" forKey:@"totalSpace"];
        [prgeTable reloadData];
    }else
    {
        [ dicion setValue:@"0" forKey:@"num"];
    
    }
    [[OrderList defaultStore] addOrederList:dicion];
    //NSLog(@"subOne");
   
}

//用reloadData方法重新加载所有cell以更新数据

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //NSLog(@"sectionHeaderHeight:%lf",tableView.sectionHeaderHeight);
    return tableView.sectionHeaderHeight;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"今日优惠    订餐热线：15993161908";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([allMutableArray count]==0) {
        return 0;
    }
    else
        return [allMutableArray count];
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
    [cell setBackgroundColor:[UIColor clearColor]];
    for (UIView *view in  cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSMutableDictionary *diction2=[allMutableArray objectAtIndex:indexPath.row];
    [cell addCellHeadImageName:@"02.jpg" CGRect:CGRectMake(5, 5, 60, 50)];
    [diction2 setValue:[NSString stringWithFormat:@"%@",[diction2 objectForKey:@"O_unitprice" ]] forKey:@"signleSpace"];
    [cell addTextViewText:[NSString stringWithFormat:@"总价：%@￥", [diction2 objectForKey:@"totalSpace" ]] CGRect:CGRectMake(70, 30, 140, 25)];
    [cell addTextViewText:[NSString stringWithFormat:@"单价：%@￥/p", [diction2 objectForKey:@"O_unitprice" ]] CGRect:CGRectMake(70, 10, 95, 25)];
    [cell addTextViewText:[NSString stringWithFormat:@"数量：%@", [diction2 objectForKey:@"num" ]] CGRect:CGRectMake(165, 10, 90, 25)];
    [cell addTitleLabel:[NSString stringWithFormat:@"%@", [diction2 objectForKey:@"O_name" ]] CGRect:CGRectMake(70, 5, 250, 15)];
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
    
    FSCell *cell=(FSCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    if (detailViewController==nil)
    {
        detailViewController=[[OODetailViewController alloc]init ];
       // NSLog(@"OODetailViewController alloc");
    }
    /*for (UIView *view in  cell.contentView.subviews) {
        [view removeFromSuperview];
    }*/
    [self.tabBarController.navigationController pushViewController:detailViewController animated:YES];
     //NSLog(@"OODetailViewController alloc");
    
    [cell setSelectionStyle:UITableViewCellAccessoryNone];
}


#pragma mark - XML Delegate 

-(void)xmlParserFinished:(NSArray *)array{
    for (int i=0; i<[array count]; i++) {
        NSDictionary *diction1=[array objectAtIndex:i];
        diction=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[diction1 objectForKey:@"id"],@"id",[diction1 objectForKey:@"O_name" ],@"O_name",[diction1 objectForKey:@"O_unitprice" ],@"O_unitprice",@"0",@"num",@"0",@"totalSpace", nil];
        [allMutableArray addObject:diction];
        //NSLog(@"asddfdssdds");
    }

    [prgeTable reloadData];
   // NSLog(@"asddfdssdds");
}

@end
