//
//  ThirdViewController.h
//  OrederOS
//
//  Created by Edward on 13-5-8.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    UITableView *prgeTable;
    NSMutableArray *allMutableArray;
    NSMutableArray *tempMutableArray;
   }


@property (retain, nonatomic) IBOutlet UILabel *totolPrice;

@end
