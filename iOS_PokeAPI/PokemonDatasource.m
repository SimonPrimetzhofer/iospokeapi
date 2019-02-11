//
//  PokemonDatasource.m
//  iOS_PokeAPI
//
//  Created by Primetzhofer on 11.02.19.
//  Copyright © 2019 Primetzhofer. All rights reserved.
//

#import "PokemonDatasource.h"

@implementation PokemonDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemon"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Zelle %ld", (long)indexPath.row];
    
    return cell;
}

@end


