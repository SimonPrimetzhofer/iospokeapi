//
//  DetailViewController.m
//  iOS_PokeAPI
//
//  Created by Primetzhofer on 11.02.19.
//  Copyright © 2019 Primetzhofer. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pName;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", [NSString stringWithFormat:@"Zeile %ld", self.row]);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.pName.text = [defaults objectForKey:@"detailUrl"];
    
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
