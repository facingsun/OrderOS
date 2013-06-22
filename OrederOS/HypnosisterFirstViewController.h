//
//  HypnosisterFirstViewController.h
//  OrederOS
//
//  Created by Edward on 13-5-8.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSXml.h"

@class EGOImageView;
@interface HypnosisterFirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,xmlDelegate>{
     EGOImageView *adImageView;
     NSArray *ADArray;
    UITableView *prgeTable;
    NSMutableArray *allMutableArray;
    NSMutableDictionary *diction;
    int caitag;
}




@end
