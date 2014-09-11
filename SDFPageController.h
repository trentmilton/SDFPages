//
//  SDFPageController.h
//  SDFPages
//
//  Created by Trent Milton on 10/09/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

@class SDFPagesController;

@interface SDFPageController : NSViewController

@property (nonatomic, weak) SDFPagesController *pagesController;

- (IBAction)previousPage:(id)sender;
- (IBAction)nextPage:(id)sender;

@end
