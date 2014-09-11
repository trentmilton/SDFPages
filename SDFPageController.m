//
//  SDFPageController.m
//  SDFPages
//
//  Created by Trent Milton on 10/09/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import "SDFPageController.h"
#import "SDFPagesController.h"

@implementation SDFPageController

- (IBAction)previousPage:(id)sender
{
    [self.pagesController previousPage];
}

- (IBAction)nextPage:(id)sender
{
    [self.pagesController nextPage];
}


@end
