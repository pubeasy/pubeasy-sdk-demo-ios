#import "PubeasyHomeViewController.h"
#import "PubeasyInterstitialViewController.h"
#import "PubeasyRewardedViewController.h"
#import "PubeasyBannerViewController.h"
#import "PubeasySplashViewController.h"
#import "PubeasyNativeViewController.h"

@interface PubeasyHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *items;

@end

@implementation PubeasyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Pubeasy";

    self.items = @[ @"Interstitial", @"Rewarded", @"Banner", @"Splash", @"Native" ];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.items[indexPath.row];
    UIViewController *vc = nil;
    if ([title isEqualToString:@"Interstitial"]) {
        vc = [[PubeasyInterstitialViewController alloc] init];
    } else if ([title isEqualToString:@"Rewarded"]) {
        vc = [[PubeasyRewardedViewController alloc] init];
    } else if ([title isEqualToString:@"Banner"]) {
        vc = [[PubeasyBannerViewController alloc] init];
    } else if ([title isEqualToString:@"Splash"]) {
        vc = [[PubeasySplashViewController alloc] init];
    } else if ([title isEqualToString:@"Native"]) {
        vc = [[PubeasyNativeViewController alloc] init];
    }
    if (vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end


