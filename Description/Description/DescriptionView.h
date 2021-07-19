//
//  DescriptionView.h
//  Description
//
//  Created by 王潇 on 2021/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DescriptionModel;

@interface DescriptionView : UIView

//  滤镜名称Label
@property (nonatomic, strong) UILabel *titleLabel;
//  滤镜风格Label
@property (nonatomic, strong) UILabel *styleLabel;
//  圆点
@property (nonatomic, strong) UIView *circleView;
//  色调Label
@property (nonatomic, strong) UILabel *tonalLabel;
//  推荐场景View
@property (nonatomic, strong) UIView *recommendView;
//  推荐场景Label
@property (nonatomic, strong) UILabel *recommendLabel;
//  滤镜描述相关Model
@property (nonatomic, strong) DescriptionModel *model;
//  更新滤镜描述信息
- (void)updateDescription;

@end


@interface DescriptionModel : NSObject

//  滤镜名称
@property (nonatomic, strong) NSString *titleText;

//  滤镜风格
@property (nonatomic, strong) NSString *styleText;

//  滤镜色调
@property (nonatomic, strong) NSString *tonalText;

//  推荐文字
@property (nonatomic, strong) NSString *recommendText;

@end

NS_ASSUME_NONNULL_END
