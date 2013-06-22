//
//  HypnosisterSecondViewController.h
//  OrederOS
//
//  Created by Edward on 13-5-8.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSXml.h"

@interface HypnosisterSecondViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,xmlDelegate>{
    //UITableViewController *tableViewControll;
    UITableView *prgeTable;
    NSMutableArray *allMutableArray;
    NSMutableArray *selectMutableArray;
    NSMutableArray *tempMutableArray;
    NSMutableDictionary *diction;
    int caitag;
}
@property (retain, nonatomic) IBOutlet UISearchBar *vegeSearch;

@end
