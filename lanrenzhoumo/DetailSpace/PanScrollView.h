//
//  PanScrollView.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/8.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanScrollView : UIView
@property(nonatomic,strong)UIScrollView *panScrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,assign)NSInteger pageNum;
-(instancetype)initWithFrame:(CGRect)frame WithImgArray:(NSMutableArray*)imgArray pageNum:(NSInteger)page;
-(void)removeAllChildView;
@end
