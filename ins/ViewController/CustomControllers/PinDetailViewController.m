//
//  PinDetailViewController.m
//  仿花瓣
//
//  Created by Sper on 16/8/12.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "PinDetailViewController.h"
#import "ZOZolaZoomTransition.h"
#import "UIImageView+WebCache.h"
#import "CHTCollectionViewWaterfallLayout.h"

static NSString * cellID = @"333dsds";

@interface PinDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic , strong)UICollectionView * collectionView;
@end

@implementation PinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    CHTCollectionViewWaterfallLayout * layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 2;
    // Change individual layout attributes for the spacing between cells
    layout.minimumColumnSpacing = 10.0;
    layout.minimumInteritemSpacing = 10.0;
    //  设置collectionView的 四周的内边距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XHWaterCollectionCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:self.collectionView];
    
    
    CGFloat width = [self.model.file.width floatValue];
    CGFloat height = [self.model.file.height floatValue];
    CGFloat curentHeight = [UIScreen mainScreen].bounds.size.width / width * height;
    
    self.imageView = [UIImageView new];
    self.imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, curentHeight);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.file.realImageKey]];
    [self.collectionView addSubview:self.imageView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeZero;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
