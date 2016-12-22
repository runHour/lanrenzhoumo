//
//  MainTableViewCell.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/10/28.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "MainTableViewCell.h"
#import "MainSpaceModel.h"
#import <UIImageView+WebCache.h>
@interface MainTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *point;


@end
@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mainText.numberOfLines=2;
    
}
//用MODel设置cell属性
-(void)setCellWithModel:(MainSpaceModel*)model{
    self.mainText.text=model.title;
    self.dianming.text=model.poi_name;
   self.priceLabel.text=[NSString stringWithFormat:@"¥%ld",[model.price integerValue]];
    self.sectionLabel.text=model.category;
    [self.backImgView sd_setImageWithURL:model.front_cover_image_list[0] placeholderImage:[UIImage imageNamed:@"loading_image"]];
   // [self.backImgView sd_setImageWithURL:model.front_cover_image_list[0]];
    self.timelabel.text=model.time_info;
    self.category_id=model.category_id;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
