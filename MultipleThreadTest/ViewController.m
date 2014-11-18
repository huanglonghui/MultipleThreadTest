//
//  ViewController.m
//  MultipleThreadTest
//
//  Created by 黄龙辉 on 14/10/28.
//  Copyright (c) 2014年 黄龙辉. All rights reserved.
//

#import "ViewController.h"
#import "GCDViewController.h"


@interface ViewController ()

@property(nonatomic, strong)UILabel *label;

@property(nonatomic, strong)NSThread *thread;


@end

@implementation ViewController{
    
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.navigationItem.title = @"NThread";
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.backgroundColor = [UIColor blueColor];
    startButton.frame = CGRectMake(10, 60, 100, 30);
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *endButton = [UIButton buttonWithType:UIButtonTypeCustom];
    endButton.frame = CGRectMake(140, 60, 100, 30);
    [endButton setTitle:@"结束" forState:UIControlStateNormal];
    [endButton addTarget:self action:@selector(end) forControlEvents:UIControlEventTouchUpInside];
    endButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:endButton];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 100)];
    self.label.text = @"未开始";
    [self.view addSubview:self.label];
    
    NSThread *main = [NSThread mainThread];
    [main setName:@"main"];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
}

- (void)next
{
    GCDViewController *gcdViewCtrl = [[GCDViewController alloc] init];
    [self.navigationController pushViewController:gcdViewCtrl animated:YES];
}


- (void)start
{
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(count) object:nil];
    [self.thread setName:@"customThread"];
    [self.thread start];
}

- (void)end{
    [self.thread cancel];
    self.thread = nil;
}


- (void)count
{
    for (int i = 0; i < 1000; ++i) {
        for (int j = 0; j < 1000; ++j) {
            for (int z = 0; z < 1000; ++z) {
                NSDictionary *dic = @{@"i":@(i), @"j":@(j), @"z":@(z)};
                [self performSelectorOnMainThread:@selector(display:) withObject:dic waitUntilDone:NO];
                [NSThread sleepForTimeInterval:0.1f];
            }
        }
    }
}

- (void)display:(NSMutableDictionary *)aDic
{
    NSNumber *i = aDic[@"i"];
    NSNumber *j = aDic[@"j"];
    NSNumber *z = aDic[@"z"];
    self.label.text = [NSString stringWithFormat:@"i:%d j:%d z:%d", [i intValue], [j intValue], [z intValue]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
