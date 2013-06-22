//
//  FourthViewController.m
//  OrederOS
//
//  Created by Edward on 13-5-8.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "FourthViewController.h"
#import "FSCell.h"
#import "HelporAboutViewController.h"
#import "TCWBGlobalUtil.h"
#import "key.h"
#import "CoreText/CoreText.h"


@interface FourthViewController (){
    NSArray *sectionarray;
    UIAlertView *alerDialog;
    HelporAboutViewController *helpViewController;
}

-(void)developmentcell;
- (void)onLogInOAuthButtonPressed;

@end

@implementation FourthViewController
@synthesize weiboEngine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"更多...", @"Third");
        self.tabBarItem.image = [UIImage imageNamed:@"更多..."];
        
        
        prgeTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-88 ) style:UITableViewStyleGrouped];
        [prgeTable setBackgroundColor:[UIColor clearColor]];
        prgeTable.delegate=self;
        prgeTable.dataSource=self;
        [prgeTable setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:prgeTable];

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.navigationItem setRightBarButtonItem:nil];
    [self.tabBarController.navigationItem  setLeftBarButtonItem:nil];
    [self.tabBarController.navigationItem setTitle:@"我还可以"];
   

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSDictionary *diction1=[[NSDictionary alloc]initWithObjectsAndKeys:@"订单详情",@"name",@"dingdan.jpg",@"icon", nil ];
    NSDictionary *diction2=[[NSDictionary alloc]initWithObjectsAndKeys:@"呼叫工作人员",@"name",@"hujiao.jpg",@"icon", nil ];
    NSArray *rowArray1=[[NSArray alloc]initWithObjects:diction1,diction2, nil];
    NSDictionary *diction3=[[NSDictionary alloc]initWithObjectsAndKeys:@"分享",@"name",@"fenxiang.jpg",@"icon", nil ];
    NSDictionary *diction4=[[NSDictionary alloc]initWithObjectsAndKeys:@"我们的位置",@"name",@"weizhi.png",@"icon", nil ];
    NSDictionary *diction5=[[NSDictionary alloc]initWithObjectsAndKeys:@"留言板",@"name",@"liuyan.jpg",@"icon", nil ];
    NSArray *rowArray2=[[NSArray alloc]initWithObjects:diction3,diction4,diction5, nil];
    NSDictionary *diction6=[[NSDictionary alloc]initWithObjectsAndKeys:@"关于我们",@"name",@"guanyu.jpg",@"icon", nil ];
    NSDictionary *diction7=[[NSDictionary alloc]initWithObjectsAndKeys:@"开发团队",@"name",@"kaifa.jpg",@"icon", nil ];
    NSArray *rowArray3=[[NSArray alloc]initWithObjects:diction6,diction7, nil];
    sectionarray=[[NSArray alloc]initWithObjects:rowArray1,rowArray2,rowArray3, nil];
    [diction1 release];
    [diction2 release];
    [diction3 release];
    [diction4 release];
    [diction5 release];
    [diction6 release];
    [diction7 release];
    [rowArray1 release];
    [rowArray2 release];
    [rowArray3 release];
    TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:@"http://www.ying7wang7.com"];
    [engine setRootViewController:self];
    //[engine setRedirectURI:@"http://www.ying7wang7.com"];
    self.weiboEngine = engine;
    
    [engine release];

}

-(void)dealloc{
    
    [alerDialog release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)developmentcell{
    if (!alerDialog) {
        alerDialog=[[UIAlertView alloc]initWithTitle:@"图灵工作室制作" message:@"qq:1289008971\n联系电话：15603773532\n邮箱：1289008971@qq.com\n地址：河南南阳市宛城区长江路80号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alerDialog.alertViewStyle=UIAlertViewStyleDefault;
    }
    [alerDialog show];
}
//用reloadData方法重新加载所有cell以更新数据

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [sectionarray count];
}
/*-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"今日优惠    订餐热线：15993161908";
}*/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[sectionarray objectAtIndex:section]count];

}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   // return 60;
//}

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
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setTag:indexPath.row];
    
    NSArray *array=[sectionarray objectAtIndex:indexPath.section];
    NSDictionary *dic=[array objectAtIndex:indexPath.row];
    //[cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[dic objectForKey:@"icon"]]]];
    //NSLog(@"cell.frame.size.height=%lf",cell.frame.size.height);
    [cell addCellHeadImageName:[NSString stringWithFormat:@"%@",[dic objectForKey:@"icon"]] CGRect:CGRectMake(12, 2, 40,40)];
    [cell addTitleLabel:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] CGRect:CGRectMake(58, 5, 200,34)];
   // [cell.textLabel setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
    //cell.textLabel.text=[NSString stringWithFormat:@"%@",[tempMutableArray objectAtIndex:indexPath.row ]];
    [CellIdentifier release];
    return cell;
}

- (void)onLogInOAuthButtonPressed
{
    // 分享(自带登录功能)
    [self.weiboEngine UIBroadCastMsgWithContent:@"欢迎光临本店，地址：河南南阳市宛城区长江路80号http://blog.csdn.net/lianbaixue"
                                       andImage:[UIImage imageNamed:@"guanyu.png"]
                                    parReserved:nil
                                       delegate:self
                                    onPostStart:@selector(postStart)
                                  onPostSuccess:@selector(createSuccess:)
                                  onPostFailure:@selector(createFail:)];
    
}

#pragma mark -
#pragma mark - creatSuccessOrFail

- (void)postStart {
    NSLog(@"%s", __FUNCTION__);
    //    [self showAlertMessage:@"开始发送"];
}

- (void)createSuccess:(NSDictionary *)dict {
    NSLog(@"%s %@", __FUNCTION__,dict);
    if ([[dict objectForKey:@"ret"] intValue] == 0) {
        [self showAlertMessage:@"发送成功！"];
    }else {
        [self showAlertMessage:@"发送失败！"];
    }
}

- (void)createFail:(NSError *)error {
    NSLog(@"error is %@",error);
    [self showAlertMessage:@"发送失败！"];
}

- (void)showAlertMessage:(NSString *)msg {
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:msg
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
}


#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //FSCell *cell=(FSCell *)[tableView cellForRowAtIndexPath:indexPath];
    //[cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    //if (detailViewController==nil)
  //  {
      //  detailViewController=[[OODetailViewController alloc]init ];
      //  NSLog(@"OODetailViewController alloc");
    //}
    /*for (UIView *view in  cell.contentView.subviews) {
     [view removeFromSuperview];
     }*/
    //[self.tabBarController.navigationController pushViewController:detailViewController animated:YES];
    //NSLog(@"OODetailViewController alloc");
    
    //[cell setSelectionStyle:UITableViewCellAccessoryNone];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            NSLog(@"订单详情");
        }else if(indexPath.row==1){
            NSLog(@"呼叫工作人员");
        }
      
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            NSLog(@"分享");
            [self.weiboEngine cancelAllRequest];
            [self onLogInOAuthButtonPressed];
            
            
        }
        else if(indexPath.row==1){
            NSLog(@"我们的位置");
        }
        else if(indexPath.row==2){
            NSLog(@"留言板");
        }
        
    }else if(indexPath.section==2){
        if (indexPath.row==0) {
            if (!helpViewController) {
                helpViewController=[[HelporAboutViewController alloc]initWithCag:1];
            }
            if (helpViewController) {
                [self.navigationController pushViewController:helpViewController animated:YES];
            }
        }else{
            // if (indexPath.section==2&&indexPath.row==1) {
            [self developmentcell];
            // }
        }
    }


}


@end
