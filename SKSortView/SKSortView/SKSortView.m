//
//  SortView.m
//  SKSortView
//
//  Created by Stepan Khapugin on 03/02/15.
//  Copyright (c) 2015 Stepan Khapugin. All rights reserved.
//

#import "SKSortView.h"

@interface SKSortView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation SKSortView

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype) init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setSortedString:(NSString *)sortedString {
    self.textLabel.text = [self.class sortString:sortedString];
    _sortedString = sortedString;
}

- (void) setup {
    self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.textLabel.numberOfLines = 0;
    [self addSubview:self.textLabel];
}

- (void) layoutSubviews {
    [super layoutSubviews];
   
    if (!self.textLabel) {
        [self setup];
    }
    self.textLabel.frame = self.bounds;
}


+ (NSString *) sortString:(NSString *)string {
    
    NSMutableArray *numbers = [[self numbersFromString:string] mutableCopy];
    NSString * s = [self sort:numbers];
    return s;
}

+ (NSArray *) numbersFromString:(NSString *)string {
    NSArray *numberStrings = [string componentsSeparatedByString:@" "];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSMutableArray *numbers = [NSMutableArray new];
    for (NSString *string in numberStrings) {
        NSNumber *num = [formatter numberFromString:string];
        if (num) {
            [numbers addObject:num];
        }
    }
    
    return numbers;
}

+ (NSString *) stringFromNumbers:(NSArray *)numbers {
    
    NSMutableArray *strings = [NSMutableArray new];
    for (NSNumber *number in numbers) {
        NSString *num = [NSString stringWithFormat:@"%ld", [number integerValue]];
        [strings addObject:num];
    }
    
    return [strings componentsJoinedByString:@" "];;
}

+ (NSString *) sort:(NSMutableArray *)a {
    
    NSArray *gaps = @[@121, @40, @13, @4, @1];
    NSMutableArray *steps = [NSMutableArray new];
    
    for (NSNumber *gapNum in gaps)
    {
        NSInteger gap = [gapNum integerValue];
        
        for (NSInteger i = gap; i < a.count; i += 1)
        {
            NSNumber *temp = a[i];
            NSInteger j;
            for (j = i; j >= gap && a[j - gap] > temp; j -= gap)
            {
                a[j] = a[j - gap];
            }
            a[j] = temp;
        }
        
        NSString *stepString = [NSString stringWithFormat:@"the %ld-sorted array is %@", gap, [self stringFromNumbers:a]];
        [steps addObject:stepString];
    }
    
    return [steps componentsJoinedByString:@"\r"];
}

@end
