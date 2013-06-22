//
//  ThirdViewController.m
//  OrederOS
//
//  Created by Edward on 13-5-8.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "ThirdViewController.h"
#import "FSCell.h"
#import "OODetailViewController.h"
#import "OrderList.h"

@interface ThirdViewController (){
    OODetailViewController *detailViewController;
   // double totolPriceM;
    
}

@end

@implementation ThirdViewController
@synthesize totolPrice=_totolPrice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = NSLocalizedString(@"购物车", @"饭桌");
        self.tabBarItem.image = [UIImage imageNamed:@"second.png"];
        
        prgeTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-132 )];
        prgeTable.delegate=self;
        prgeTable.dataSource=self;
        //prgeTable.bounces=NO;
        [prgeTable setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:prgeTable];
        //totolPriceM=0;
        }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.navigationItem setRightBarButtonItem:nil];
    [self.tabBarController.navigationItem  setLeftBarButtonItem:nil];
    [self.tabBarController.navigationItem setTitle:@"我的餐桌"];
    if (allMutableArray!=nil) {
        [allMutableArray removeAllObjects];
        
        [allMutableArray release];
    }
    allMutableArray=[[NSMutableArray alloc]initWithArray:[[OrderList defaultStore] orederListArray]];
    tempMutableArray=allMutableArray;
   // totolPriceM=0;

    [prgeTable reloadData];
    
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //allMutableArray=[[NSMutableArray alloc]initWithCapacity:0 ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [dicion setValue:[NSString stringWithFormat:@"%.1lf",totalPrace] forKey:@"totalSpace"];
    //totolPriceM=0;
    //totolep+=singlePrace;
    [[OrderList defaultStore]setTotoleValue:singlePrace];
    [prgeTable reloadData];
    [[OrderList defaultStore] addOrederList:dicion];
    
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
        //totolPriceM=0;
        
        [prgeTable reloadData];
    }else if(num==0)
    {
        //totolep-=singlePrace;
        [[OrderList defaultStore]setTotoleValue:-singlePrace];
        [ dicion setValue:[NSString stringWithFormat:@"%d",num] forKey:@"num"];
        [dicion setValue:@"0" forKey:@"totalSpace"];
        [tempMutableArray removeObjectAtIndex:btn.tag];
        //totolPriceM=0;
        [_totolPrice setText:@"总价:0￥"];
        [prgeTable reloadData];
    }
    
    [[OrderList defaultStore] addOrederList:dicion];
}
//用reloadData方法重新加载所有cell以更新数据

#pragma mark - Table view data source
/*-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"今日优惠    订餐热线：15993161908";
}
*/
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
    NSMutableDictionary *diction2=[allMutableArray objectAtIndex:indexPath.row];
    
    
    [diction2 setValue:[NSString stringWithFormat:@"%@",[diction2 objectForKey:@"O_unitprice" ]] forKey:@"signleSpace"];
    NSString *totolstring=[diction2 objectForKey:@"totalSpace" ];
  
    FSCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[[FSCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        // totolPriceM+=totolstring.doubleValue;
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    for (UIView *view in  cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    [cell addCellHeadImageName:@"02.jpg" CGRect:CGRectMake(5, 5, 60, 50)];
    [_totolPrice setText:[NSString stringWithFormat:@"总价:%.1lf￥",[[OrderList defaultStore]totolep]]];
    [cell addTextViewText:[NSString stringWithFormat:@"总价：%@￥", totolstring] CGRect:CGRectMake(70, 30, 140, 25)];
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
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FSCell *cell=(FSCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    if (detailViewController==nil)
    {
        detailViewController=[[OODetailViewController alloc]init ];
        //NSLog(@"OODetailViewController alloc");
    }
    /*for (UIView *view in  cell.contentView.subviews) {
     [view removeFromSuperview];
     }*/
    [self.tabBarController.navigationController pushViewController:detailViewController animated:YES];
    //NSLog(@"OODetailViewController alloc");
    
    [cell setSelectionStyle:UITableViewCellAccessoryNone];
}

- (void)dealloc {
  
    [_totolPrice release];
    [super dealloc];
}
@end
