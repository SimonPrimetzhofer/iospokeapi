//
//  ViewController.m
//  iOS_PokeAPI
//
//  Created by Primetzhofer on 06.02.19.
//  Copyright © 2019 Primetzhofer. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSInteger selectedRow;
@property (strong, nonatomic) NSArray *response;
@property (strong, nonatomic) NSString* detailUrl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self load];
}

-(void) load {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"bin vorm fetch");
        
        self.response = [self fetchData];
        
        /*NSDictionary *dict = [self.response objectAtIndex:0];
        NSString *test = [NSString stringWithFormat:@"Pokemon %@", [dict objectForKey:@"name"]];
        NSLog(@"%@",test);*/
        
        /*for(id obj in self.response) {
         NSDictionary *dict = obj;
         NSString *name = [dict objectForKey:@"name"];
         NSLog(@"name of pokemon: %@", name);
         }*/
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Back in main");
            [self.tableView setDelegate:self];
            [self.tableView setDataSource:self];
            //self.tableView.rowHeight = UITableViewAutomaticDimension;
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
    dvc.detailUrl = self.detailUrl;
}

-(void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"cell clicked %@", indexPath);
    self.selectedRow = indexPath.row;
    
    NSDictionary *dict = [self.response objectAtIndex: (long) indexPath.row];
    
    NSString *url = [dict objectForKey:@"url"];
    
    self.detailUrl = url;
    
    /*NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:url forKey:@"detailUrl"];*/
    
    
    [self performSegueWithIdentifier:@"toDetailView" sender: self];
    
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
    return [self.response count];
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
