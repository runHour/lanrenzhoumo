//
//  PriceTableViewCell.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/5.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categroyImg;
@property (weak, nonatomic) IBOutlet UILabel *categroyLabel;
@property(nonatomic,strong)NSString *imgString;
@end
