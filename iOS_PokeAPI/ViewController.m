//
//  ViewController.m
//  iOS_PokeAPI
//
//  Created by Primetzhofer on 06.02.19.
//  Copyright © 2019 Primetzhofer. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

#define NUM_ELEMENTS 964

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSInteger selectedRow;
@property (strong, nonatomic) NSArray *response;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*self.tableView.delegate = self;
    self.tableView.dataSource = self;*/
 
    [self load];
}

-(void) load {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"bin vorm fetch");
        self.response = [self fetchData];
        
        NSDictionary *dict = [self.response objectAtIndex:0];
        NSString *test = [NSString stringWithFormat:@"Pokemon %@", [dict objectForKey:@"name"]];
        NSLog(@"%@",test);
        
        /*for(id obj in self.response) {
         NSDictionary *dict = obj;
         NSString *name = [dict objectForKey:@"name"];
         NSLog(@"name of pokemon: %@", name);
         }*/
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Back in main");
            [self.tableView setDelegate:self];
            [self.tableView setDataSource:self];
            [self.tableView reloadData];
        });
        
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    DetailViewController *dvc = (DetailViewController *) segue.destinationViewController;
    dvc.row = self.selectedRow;
}

-(void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"cell clicked %@", indexPath);
    self.selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"toDetailView" sender: self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: indexPath.row forKey:@"selectedRow"];
    [defaults setObject:@"testest" forKey:@"detailUrl"];
    
    //Defaults werden über Laufzeit hinweg gespeichert
    //UserDefaults ist vergleichbar mit LocalStorage in JavaScript
    
}
- (NSArray *) fetchData {
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:@"https://pokeapi.co/api/v2/pokemon/?limit=964"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    NSArray *array = [dict objectForKey:@"results"];
    
    return array;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return NUM_ELEMENTS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemon"];
    
    NSDictionary *dict = [self.response objectAtIndex: (long) indexPath.row];
    /*NSString *test = [NSString stringWithFormat:@"Pokemon %@", [dict objectForKey:@"name"]];
    NSLog(@"%ld %@",(long) indexPath.row, test);*/
    
    cell.textLabel.text = [NSString stringWithFormat:@"Pokemon %@", [dict objectForKey:@"name"]];
    
    return cell;
}


@end
