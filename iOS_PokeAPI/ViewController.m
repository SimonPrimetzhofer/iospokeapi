//
//  ViewController.m
//  iOS_PokeAPI
//
//  Created by Primetzhofer on 06.02.19.
//  Copyright © 2019 Primetzhofer. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "PokemonDatasource.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) PokemonDatasource *dataSource;
@property (nonatomic) NSInteger selectedRow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [PokemonDatasource new];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
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
    [defaults setObject:@"xyz" forKey:@"myKey"];
    
    //Defaults werden über Laufzeit hinweg gespeichert
    //UserDefaults ist vergleichbar mit LocalStorage in JavaScript
    
}


@end
