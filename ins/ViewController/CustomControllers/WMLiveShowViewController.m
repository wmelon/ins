//
//  WMLiveShowViewController.m
//  ins
//
//  Created by Sper on 16/11/14.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "WMLiveShowViewController.h"
#import "WMLiveShowCell.h"

static NSString * cellID = @"WMLiveShowCell";
@interface WMLiveShowViewController ()
@property (nonatomic , strong)NSArray * lives;
@property (nonatomic , assign)NSInteger currentIndex;
@end

@implementation WMLiveShowViewController

- (void)setIntentDic:(NSDictionary *)intentDic{
    _lives = intentDic[@"lives"];
    _currentIndex = [intentDic[@"currentIndex"] integerValue];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = self.collectionView.bounds.size;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerClass:[WMLiveShowCell class] forCellWithReuseIdentifier:cellID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WMLiveShowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell setModel:_lives[_currentIndex]];
    [cell setParentVc:self];
    return cell;
}

- (BOOL)shouldShowGetMore{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
