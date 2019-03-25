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
@property (strong, nonatomic) NSDictionary *detailData;
@property (weak, nonatomic) IBOutlet UILabel *pTypes;
@property (weak, nonatomic) IBOutlet UIImageView *pImage;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"%@", [NSString stringWithFormat:@"Zeile %ld", self.row]);
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //NSLog(@"im detail %@", [defaults objectForKey:@"detailUrl"]);
    [self load: self.detailUrl];
    
}

-(void) load: (NSString *) detailUrl {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"bin vorm fetch");
        
        self.detailData = [self fetchData: detailUrl];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Back in main");
            self.pName.text = [self.detailData objectForKey:@"name"];
            
            for(id obj in [self.detailData objectForKey:@"types"]) {
                
                NSDictionary *typeData = obj;
                NSDictionary *types = [typeData objectForKey:@"type"];
                NSString *name = [types objectForKey:@"name"];

                self.pTypes.text = [self.pTypes.text stringByAppendingFormat:@"%@ ", name];
            }
            
            NSDictionary *images = [self.detailData objectForKey:@"sprites"];
            NSString *imageUrl = [images objectForKey:@"front_default"];
            
            NSURL *url = [NSURL URLWithString: imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:url];
            
            UIImage *image = [UIImage imageWithData: data];
            self.pImage.image = image;
            
        });
        
    });
    
}

- (NSDictionary *) fetchData: (NSString *) dataUrl {
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:dataUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    return dict;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
