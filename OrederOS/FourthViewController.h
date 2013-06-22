//
//  FourthViewController.h
//  OrederOS
//
//  Created by Edward on 13-5-8.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCWBEngine.h"

@interface FourthViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    TCWBEngine *weiboEngine;
    UITableView *prgeTable;
}

@property (nonatomic, retain) TCWBEngine   *weiboEngine;

- (void)showAlertMessage:(NSString *)msg;
@end
