//
//  TipCollectionViewCell.m
//  PayMobileClient
//
//  Created by Colden Prime on 6/8/14.
//  Copyright (c) 2014 IntrepidPursuits. All rights reserved.
//

#import "TipCollectionViewCell.h"

@implementation TipCollectionViewCell

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    if (selected) {
        self.tipAmountLabel.textColor = [UIColor colorWithHexValue:0x626576];
    } else {
        self.tipAmountLabel.textColor = [UIColor colorWithHexValue:0xC2C2C2];
    }
}

@end