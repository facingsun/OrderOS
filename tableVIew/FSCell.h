//
//  FSCell.h
//  TableViewDemo
//
//  Created by Edward on 13-3-29.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EGOImageView;

@interface FSCell : UITableViewCell{
    
    //UIImage *imageTag;
    //NSString *imageName;
    UILabel *cellLabel;
    //UILabel *label;
    //UITextView *textLabel;
    //UIImage *tag;
    //UITextView *textView;
    @private
    
    EGOImageView *imageView;
    UIButton *cellButono;
}

-(void)addCellHeadImageName:(NSString *)name CGRect:(CGRect)rect;
-(void)addTitleLabel:(NSString *)string CGRect:(CGRect)rect;
-(void)addTextViewText:(NSString *)string CGRect:(CGRect)rect;
-(void)addCellButton:(UIButton *)btn;
//-(NSString *)TitleLabel;
@end
