//
//  ViewController.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/5.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "ViewController.h"

static NSString *const kLayerCellIdentifier = @"kLayerCellIdentifier";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kLayerCellIdentifier];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLayerCellIdentifier];
    cell.textLabel.text = [self.dataSource[indexPath.row] firstObject];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class class = NSClassFromString([self.dataSource[indexPath.row] lastObject]);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@[@"layer content", @"ContentVC"],
                        @[@"CAShapeLayer", @"ShapeLayer"],
                        @[@"CAEmitterLayer_fb点赞效果", @"EmitterLayer"],
                        @[@"CAEmitterLayer_下雪效果", @"EmitterLayer_Snow"],
                        @[@"GradientLayer渐变效果", @"GradientLayer"],
                        @[@"ReplicatorLayer", @"ReplicatorLayer"],
                        @[@"ReplicatorLayer 2", @"ReplicatorLayer2"],
                        @[@"ReplicatorLayer 倒影", @"ReplicatorLayer3"],
                        @[@"ReplicatorLayer 文字路径", @"ReplicatorLayer4"],
                        @[@"ScrollLayer", @"ScrollLayer"],
                        @[@"CATransformLayer", @"TransformLayer"]
                         ];
    }
    return _dataSource;
}


@end
