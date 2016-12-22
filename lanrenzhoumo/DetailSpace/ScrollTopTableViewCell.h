//
//  ScrollTopTableViewCell.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/5.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollTopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong)NSArray *imgsArray;
-(void)setScrollViewWithImg:(NSArray*)imgArray;
@end
