//
//  AllShowsDataSource.m
//  bandRides
//
//  Created by Marc Kluver on 3/6/13.
//  Copyright (c) 2013 DJ Tarazona. All rights reserved.
//

#import "AllShowsDataSource.h"
#import "AFNetworking.h"
#import "ShowData.h"

@implementation AllShowsDataSource

-(id) init {
    if (self = [super init]){
        self.showsArray = nil;
        
        NSString *urlString = @"http://kluver.homeunix.com:8080/~marc/shows.php?json";
        
        AFJSONRequestOperation *networkOp = [[AFJSONRequestOperation alloc]
                                             initWithRequest:[[NSURLRequest alloc] initWithURL:
                                                              [NSURL URLWithString:urlString]]];
        
        [networkOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@", responseObject);
            
            self.showsArray = [NSMutableArray new];
            
            for (NSDictionary *dict in responseObject[@"shows"]) {
                ShowData *show = [ShowData new];
                
                show.bandName = dict[@"bandName"];
                show.bandImage = dict[@"bandImage"];
                show.bandScheduleID = dict[@"bandScheduleID"];
                show.Date = dict[@"Date"];
                show.Location_Address = dict[@"Location_Address"];
                show.Location_City = dict[@"Location_City"];
                show.Location_GPS_Lat = dict[@"Location_GPS_Lat"];
                show.Location_GPS_Lng = dict[@"Location_GPS_Lng"];
                show.bandID = dict[@"bandID"];
                
                [self.showsArray addObject:show];
            }
            
            [self.vc.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
        
        [networkOp start];

    }
    return self;
}

@end
