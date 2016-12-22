//
//  PanScrollView.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/8.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "PanScrollView.h"
#import <UIImageView+WebCache.h>
@interface PanScrollView ()<UIScrollViewDelegate>
@property(nonatomic ,strong)NSTimer *timer;
@property(nonatomic,strong)NSArray *imgsArray;
@end

@implementation PanScrollView

-(instancetype)initWithFrame:(CGRect)frame WithImgArray:(NSMutableArray*)imgArray pageNum:(NSInteger)page{
    if (self=[super initWithFrame:frame]) {
        _imgsArray=[NSMutableArray arrayWithArray:imgArray];
        [self addSubview:self.panScrollView];
        [self addSubview:self.pageControl];
        //_panScrollView.contentOffset=CGPointMake(ScreenWidth, 300);
    
        self.pageControl.numberOfPages=imgArray.count;
        self.pageControl.currentPage=page;
        _pageNum=page;
        [self setUpTimer];
        //背景色渐变动画
        self.alpha=0;
        [UIView animateWithDuration:1 animations:^{
         self.backgroundColor=[UIColor blackColor];
            self.alpha=1.0;
        }];
      
       
    }

    return self;
}
-(void)setUpTimer{
    _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(panScroll) userInfo:nil repeats:YES];
    
}
-(void)removeTimer{
    if (_timer == nil) return;
    [_timer invalidate];
    _timer = nil;
}

-(UIScrollView*)panScrollView{
    if (!_panScrollView) {
        
        _panScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
        
        [UIView animateWithDuration:1 animations:^{
            _panScrollView.frame=CGRectMake(0, ScreenHeight/2-110, ScreenWidth, 300);
        }];
        self.panScrollView.contentSize=CGSizeMake(ScreenWidth*_imgsArray.count, 300);
        _panScrollView.delegate=self;
        _panScrollView.pagingEnabled=YES;
        _panScrollView.showsHorizontalScrollIndicator=NO;
        for (int i=0; i<_imgsArray.count; i++) {
            UIImageView *imgView=[[UIImageView  alloc]initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, _panScrollView.bounds.size.height)];
            imgView=_imgsArray[i];
            [_panScrollView addSubview:imgView];
        }

    }
    return _panScrollView;

}
-(UIPageControl*)pageControl{
    if (!_pageControl) {
        _pageControl=[[UIPageControl  alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 37)];
        _pageControl.center=CGPointMake(self.center.x, 240);
        [UIView animateWithDuration:1 animations:^{
            _pageControl.center=CGPointMake(self.center.x, ScreenHeight/2+150+30);
        }];
        
    }

    return _pageControl ;


}

-(void)panScroll{
    if (_pageNum>=_imgsArray.count) {
        [self.panScrollView setContentOffset:CGPointMake(0, 0)];
        _pageNum=0;
    }
    else{
        [UIView animateWithDuration:1 animations:^{
            [self.panScrollView setContentOffset:CGPointMake(ScreenWidth*_pageNum, 0)];
        }];
    }
    _pageControl.currentPage=_pageNum;
    _pageNum++;

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setUpTimer];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageNum=scrollView.contentOffset.x/ScreenWidth;
    _pageControl.currentPage=_pageNum;
    
}
//移除方法
-(void)removeAllChildView{

    [self.panScrollView removeFromSuperview];
    [self.pageControl removeFromSuperview];


}

@end
