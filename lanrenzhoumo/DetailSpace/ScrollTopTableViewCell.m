//
//  ScrollTopTableViewCell.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/5.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "ScrollTopTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "PanScrollView.h"
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface ScrollTopTableViewCell ()<UIScrollViewDelegate>
@property(nonatomic,assign)int count;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIPageControl *page;
@property(nonatomic,strong)NSMutableArray *imgViewArray;
@end
@implementation ScrollTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imgsArray=[NSArray array];
    _imgViewArray=[NSMutableArray array];
    _count=0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Restart:) name:@"startScroll" object:nil];
    [self setUpTimer];
    
}
-(void)setUpTimer{
_timer=[NSTimer scheduledTimerWithTimeInterval:4.5 target:self selector:@selector(scrollAction) userInfo:nil repeats:YES];

}
-(void)removeTimer{
    if (_timer == nil) return;
    [_timer invalidate];
    _timer = nil;
}

-(void)setScrollViewWithImg:(NSArray*)imgArray{
    self.imgsArray=imgArray;
    _scrollView.contentSize=CGSizeMake(ScreenWidth*self.imgsArray.count, 0);
    _scrollView.pagingEnabled=YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.delegate=self;
    _scrollView.userInteractionEnabled=YES;
    for (int i=0; i<imgArray.count; i++) {
        UIImageView *imgView=[[UIImageView    alloc]initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, _scrollView.bounds.size.height)];
          UITapGestureRecognizer *panGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgArray[i]] placeholderImage:[UIImage imageNamed:@"loading_image"]];
        imgView.tag=i;
        imgView.userInteractionEnabled=YES;
        [imgView addGestureRecognizer:panGes];
        [_imgViewArray addObject:imgView];
        [_scrollView addSubview:imgView];
    }
    [self setPageCntrol];
    
}

-(void)scrollAction{
    if (_count>=_imgsArray.count) {
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        _count=0;
    }
    else{
        [UIView animateWithDuration:1 animations:^{
            [_scrollView setContentOffset:CGPointMake(ScreenWidth*_count, 0)];
        }];
    }
    _page.currentPage=_count;
    _count++;
}

-(void)setPageCntrol{
    _page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 37)];
    _page.numberOfPages=_imgsArray.count;
    _page.center=CGPointMake(self.center.x, self.frame.size.height-37);
    _page.pageIndicatorTintColor = [UIColor whiteColor];
    _page.currentPageIndicatorTintColor = [UIColor colorWithRed:247/255.0 green:88/255.0 blue:135/255.0 alpha:1.0];
    _page.currentPage=_count;
    [self addSubview:_page];

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setUpTimer];

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _count=scrollView.contentOffset.x/ScreenWidth;
    _page.currentPage=_count;

}
//手势
-(void)panGes:(UITapGestureRecognizer*)panGes{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@(panGes.view.tag),@"tag",self.imgViewArray,@"imgArray" ,nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"scrollImg" object:self userInfo:dic];
    [self removeTimer];
    NSLog(@"1111%ld",panGes.view.tag) ;

}
//通知
-(void)Restart:(NSNotification *)noti{
    [self setUpTimer];


}

@end
