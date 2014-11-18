//
//  GCDViewController.m
//  MultipleThreadTest
//
//  Created by 黄龙辉 on 14/11/3.
//  Copyright (c) 2014年 黄龙辉. All rights reserved.
//

#import "GCDViewController.h"
#import "CustomOperation.h"

@interface GCDViewController ()<UIWebViewDelegate>

@property(nonatomic, strong)UILabel *label;
@property(nonatomic, strong)dispatch_semaphore_t semaphore;
@property(nonatomic, strong)UIWebView *webView;

@property(nonatomic, strong)CustomOperation *customOperation;

@end

@implementation GCDViewController{
    dispatch_group_t downloadGroup;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"GCD";
    
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
    
    
//    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//    self.webView.delegate = self;
//    [self.view addSubview:self.webView];
//    [self start];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
}

- (void)next
{
}


- (void)start
{
//    1
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
//        [self count]
//        [self count1];
//    });
    
//    2
//    dispatch_queue_t customQueue = dispatch_queue_create("customQueue",  DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(customQueue, ^{
//        [self count3];
//    });
//    dispatch_async(customQueue, ^{
//        [self count2];
//    });
//    
//    dispatch_barrier_async(customQueue, ^{
//        [self count3];
//    });
//    
//    dispatch_async(customQueue, ^{
//        [self count4];
//    });
//    
//    3
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self dispatchGroup_t];
//    });
    
//    4
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        dispatch_apply(3, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
//            [self count];
//            NSLog(@"i:%zu完成", i);
//        });
//    });
    
//    5
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        self.semaphore = dispatch_semaphore_create(0);
//        NSURL *serviceUrl = [NSURL URLWithString:@"http://www.taobao.com"];
//        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:serviceUrl];
//        [self.webView loadRequest:urlRequest];
//        
//        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
//        
//        NSLog(@"214");
//    });
//    6
//    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(customInvoke:) object:@(1)];
//    [invocationOperation start];
//    NSLog(@"123");
//    BOOL result = [invocationOperation result];
//    NSLog(@"%d", result);
//    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//        
//        NSThread *threadName = [NSThread currentThread];
//        NSLog(@"%@", threadName.name);
//        NSLog(@"23");
//    }];
//    [blockOperation start];
    self.customOperation = [[CustomOperation alloc] init];
    self.customOperation.completionBlock = ^{
        NSLog(@"completeBlock");
    };
    [self.customOperation start];
    [self.customOperation cancel];
    NSLog(@"234");
}

- (BOOL)customInvoke:(id)aParam
{
    NSThread *threadName = [NSThread currentThread];
    NSLog(@"%@", threadName.name);
    NSLog(@"%@", aParam);
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    dispatch_semaphore_signal(self.semaphore);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    dispatch_semaphore_signal(self.semaphore);
}



- (void)dispatchGroup_t
{
    dispatch_queue_t customQueue = dispatch_queue_create("customQueue",  DISPATCH_QUEUE_CONCURRENT);
    downloadGroup = dispatch_group_create();
    dispatch_group_enter(downloadGroup);
    dispatch_async(customQueue, ^{
        [self count5];
    });
    dispatch_group_enter(downloadGroup);
    dispatch_async(customQueue, ^{
        [self count5];
    });
    dispatch_group_enter(downloadGroup);
    dispatch_async(customQueue, ^{
        [self count5];
    });
    //    [NSThread sleepForTimeInterval:3];
//    dispatch_group_wait(downloadGroup, DISPATCH_TIME_FOREVER);
    dispatch_group_notify(downloadGroup, customQueue, ^{
        NSLog(@"3个结束");
    });
    NSLog(@"jiehs");
}

- (void)end{

}

- (void)dealloc{
    NSLog(@"CGD");
}


- (void)count
{
    for (int i = 0; i < 1000; ++i) {
        for (int j = 0; j < 1000; ++j) {
            for (int z = 0; z < 1000; ++z) {
                NSDictionary *dic = @{@"i":@(i), @"j":@(j), @"z":@(z)};
//                dispatch_sync(dispatch_get_main_queue(), ^{
//                    [self display:dic];
//                });
                
                [self showAfter:dic];
            }
        }
    }
}


- (void)count1
{
    NSDictionary *dic = @{@"i":@(4), @"j":@(5), @"z":@(6)};
    [self showAfter:dic];
}


- (void)count2
{
    NSDictionary *dic = @{@"i":@(1), @"j":@(2), @"z":@(3)};
    [self showAfter:dic];
}


- (void)count3
{
    for (int i = 0; i < 1000; ++i) {
        for (int j = 0; j < 1000; ++j) {
            if (999 == i && j == 1) {
                NSLog(@"count3 end");
            }
        }
    }
}


- (void)count4
{
    NSLog(@"afterBarrier");
}

- (void)count5
{
    for (int i = 0; i < 1000; ++i) {
        for (int j = 0; j < 1000; ++j) {
            for (int q = 0; q < 1000; ++q) {
                if (0 == i && j == 0 && 0 == q) {
                    NSLog(@"gourp_t");
                }
            }
        }
    }
//    [NSThread sleepForTimeInterval:4];
    dispatch_group_leave(downloadGroup);
}


- (void)showAfter:(NSDictionary *)aDic
{
    double delayInSecond = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond*NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self display:aDic];
    });
}



- (void)display:(NSDictionary *)aDic
{
    NSNumber *i = aDic[@"i"];
    NSNumber *j = aDic[@"j"];
    NSNumber *z = aDic[@"z"];
    self.label.text = [NSString stringWithFormat:@"i:%d j:%d z:%d", [i intValue], [j intValue], [z intValue]];
}


@end
