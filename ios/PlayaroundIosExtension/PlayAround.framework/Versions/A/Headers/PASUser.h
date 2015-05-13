//
//  PASUser.h
//  PlayAroundSDK
//
//  Created by Marc Bounthong on 07/03/15.
//  Copyright (c) 2015 Marc Bounthong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PASUser : NSObject

@property (nonatomic) NSInteger age;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *photo;

- (id)initWithUserId:(NSString*)userId age:(NSInteger)age name:(NSString*)name nickname:(NSString*)nickname distance:(NSString*)distance photo:(NSString*)photo;

@end
