//
//  FSCell.m
//  TableViewDemo
//
//  Created by Edward on 13-3-29.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "FSCell.h"
//#import "SPStatic.h"
#import "EGOImageView.h"
#import "QuartzCore/QuartZCore.h"

@implementation FSCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
    }
    return self;
}

-(void)addCellHeadImageName:(NSString *)name CGRect:(CGRect)rect{
    if (!imageView) {
        imageView=[[EGOImageView alloc]init];
    }

    imageView=[[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"Default@2x.png"]];
    imageView.layer.cornerRadius=6.0f;
    imageView.layer.masksToBounds = YES;//这两句是设置图片角的平滑度。
    if (name==nil) {
        [imageView setImage:[UIImage imageNamed:@"gouwuche.png"]];
    }
    else
    {
        [imageView setImage:[UIImage imageNamed:name]];
    }
    imageView.frame=rect;
    [self addSubview:imageView];
    //imageView.imageURL=[NSURL URLWithString:name];
    
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if(!newSuperview){
        //[imageView cancelImageLoad];
    }
}

-(void)addTitleLabel:(NSString *)string CGRect:(CGRect)rect
{
    //UILabel *cellLabel=[[UILabel alloc]initWithFrame:rect];
    if (!cellLabel) {
        //cellLabel=[[UILabel alloc]initWithFrame:rect];
        cellLabel=[[UILabel alloc]init];
        
    }
    int s=[string length];
    if (s<10)
    {
        //[titleLabel setFrame:CGRectMake(-10, 0, 150, 44)];
        [cellLabel setFont:[UIFont systemFontOfSize:16]];
        
    }
    else if(12<=s&&s<22)
    {
        //[titleLabel setFrame:CGRectMake(-10, 0, 180, 44)];
        [cellLabel setFont:[UIFont systemFontOfSize:14]];
    }
    else if(s>=22&&s<40)
    {
        [cellLabel setFont:[UIFont systemFontOfSize:9]];
    }
    else if(s>=40)
    {
       // [titleLabel setFrame:CGRectMake(-10, 0, 310, 44)];
        [cellLabel setFont:[UIFont systemFontOfSize:6]];
    }
    [cellLabel setFrame:rect];
   // cellLabel.text=string;
    [cellLabel setText:string];
    [cellLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:cellLabel];
}

-(void)addTextViewText:(NSString *)string CGRect:(CGRect)rect
{
    UITextView *textView =[[UITextView alloc]initWithFrame:rect];
    //if (!textView) {
       // textView=[[UITextView alloc]init];
        [textView setEditable:NO];
        [textView setUserInteractionEnabled:NO];
        
   // }
    //int s=[string length];
    /*if (s<20)
    {
        //[titleLabel setFrame:CGRectMake(-10, 0, 150, 44)];
        [textView setFont:[UIFont systemFontOfSize:14]];
        
    }
    else if(20<=s&&s<40)
    {
        //[titleLabel setFrame:CGRectMake(-10, 0, 180, 44)];
        [textView setFont:[UIFont systemFontOfSize:11]];
    }
    else if(s>40)
    {*/
        // [titleLabel setFrame:CGRectMake(-10, 0, 310, 44)];
        [textView setFont:[UIFont systemFontOfSize:11]];
   // }
    [textView setFrame:rect];
    [textView setText:string];
    [textView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:textView];
    [textView release];
}

-(void)addCellButton:(UIButton *)btn{
    cellButono=[[UIButton alloc]init];
    cellButono=btn;
    //[cellButono setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:cellButono];
}


-(void)dealloc{
    //[textView release];
    [cellLabel release];
    //[imageName release];
    //[imageTag release];
   // [label release];
    //[textLabel release];
    //[tag release];
    //[imageView release];
    //imageView=nil;
    //[cellButono release];
    //cellButono=nil;
    [cellButono dealloc];
   // textView=nil;
   // imageTag=nil;
    cellLabel=nil;
   // imageName=nil;
    //label=nil;
    //textLabel=nil;
    //tag=nil;
    [super dealloc];
}
@end
