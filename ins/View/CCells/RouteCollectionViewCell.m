//
//  RouteCollectionViewCell.m
//  ins
//
//  Created by Sper on 16/7/18.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "RouteCollectionViewCell.h"

#define RouteCellLeftMargin     10
#define RouteCellTopMargin      5

@interface RouteCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *startBusLine;

@property (weak, nonatomic) IBOutlet UILabel *startStation;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;

/**公交路线模型*/
@property (nonatomic , strong)AMapBusLine *	busline;
@end

@implementation RouteCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.clipsToBounds = YES;
    
        _nextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right"]];
        _nextImageView.frame = CGRectMake(0, 0, 10, 13);
        _nextImageView.center = CGPointMake(CGRectGetWidth(frame) - RouteCellLeftMargin - CGRectGetWidth(_nextImageView.bounds) / 2.0, CGRectGetHeight(frame) / 2.0);
        [self.contentView addSubview:_nextImageView];
        
        CGFloat labelWidth = CGRectGetWidth(frame) - CGRectGetWidth(_nextImageView.bounds) * 2 - RouteCellLeftMargin * 4;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(RouteCellLeftMargin + RouteCellLeftMargin , RouteCellTopMargin, labelWidth, 38)];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.text = @"更多公交详情";
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(RouteCellLeftMargin + RouteCellLeftMargin , CGRectGetMaxY(_titleLabel.frame), labelWidth, 20)];
        _subtitleLabel.font = [UIFont systemFontOfSize:12];
        _subtitleLabel.text = @"去其它地图查看";
        _subtitleLabel.textColor = UIColorFromRGB(0x9b9b9b);
        [self.contentView addSubview:_subtitleLabel];
    }
    return self;
}

- (void)setTransit:(AMapTransit *)transit{
    _transit = transit;
    
    NSMutableString * lineMutStr = [NSMutableString string];
    NSMutableString * mutStr = [NSMutableString string];

    [_transit.segments enumerateObjectsUsingBlock:^(AMapSegment * segment, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (segment.buslines.count){
            AMapBusLine * busline = [segment.buslines firstObject];
    
            NSString *  stationToStation = [NSString stringWithFormat:@"%@-%@",busline.departureStop.name ,busline.arrivalStop.name];
            NSString *  busOrBus = [self busOrBus:segment.buslines];
            
            if (idx > 0 && idx < _transit.segments.count - 1){
                [lineMutStr appendFormat:@"-->%@" , busOrBus];
                
                [mutStr appendFormat:@"-->%@",stationToStation];
            }else {
                [mutStr appendFormat:@"%@",stationToStation];
                [lineMutStr appendFormat:@"%@",busOrBus];
            }
        }
    }];
    self.time.text = [NSString stringWithFormat:@"%ld分钟",_transit.duration / 60];
    self.distance.text = [NSString stringWithFormat:@"步行%ld米",_transit.walkingDistance];
    self.startBusLine.text = lineMutStr;
    self.startStation.text = mutStr;
}
- (NSString *)busOrBus:(NSArray *)buslines{
    NSMutableString * busStr = [NSMutableString string];
    [buslines enumerateObjectsUsingBlock:^(AMapBusLine * busline, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [busline.name rangeOfString:@"("];
        NSString * busname = [busline.name substringWithRange:NSMakeRange(0, range.location)];
        
        if (idx < buslines.count - 1){
            [busStr appendFormat:@"%@/",busname];
        }else {
            [busStr appendFormat:@"%@",busname];
        }
    }];
    return busStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineHeight.constant = 0.5;
}

@end
