//
//  SDFPagesController.m
//  SDFPages
//
//  Created by Trent Milton on 10/09/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import "SDFPagesController.h"
#import "SDFPageController.h"

@interface SDFPagesController ()

@property (nonatomic) BOOL hasSetup;

@end

@implementation SDFPagesController

#pragma mark - Public

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.flow = SDFPagesFlowHorizontal;
        self.direction = SDFPagesDirectionForward;
        self.animationDuration = 2.0;
        _currentPage = 0;
    }
    return self;
}

- (void)setup
{
	self.hasSetup = YES;
    
	// CHECKS
	if (!self.contentView) {
		NSLog(@"ERROR: you must set a contentView before setup");
		return;
	}
	if (!self.pages) {
		NSLog(@"ERROR: you must set some pages before setup");
		return;
	}
	for (id o in self.pages) {
		// Class check
		if (![o isKindOfClass:[SDFPageController class]]) {
			NSLog(@"ERROR: All pages must be of type SDFPageController");
			return;
		}
	}

	// SETUP
    for (SDFPageController *pc in self.pages) {
        pc.view.frame = self.contentView.frame;
        pc.pagesController = self;
    }
    
	CGRect cvFrame = self.contentView.frame;
	self.scrollView = [[NSScrollView alloc] initWithFrame:cvFrame];
	cvFrame.size.width = cvFrame.size.width * self.pages.count;

	NSView *scrollCV = [[NSView alloc] initWithFrame:cvFrame];
	for (int i = 0; i < self.pages.count; i++) {
        SDFPageController *pageController = [self.pages objectAtIndex:i];
		NSView *page = pageController.view;
		CGRect f = page.frame;
        
        if (self.flow == SDFPagesFlowHorizontal) {
            
            // Horizontal
            if (self.direction == SDFPagesDirectionForward) {
                // Left to right
                f.origin.x = page.frame.size.width * i;
            } else {
                // Right to left
                f.origin.x = page.frame.size.width * (self.pages.count - 1 - i);
            }
            
        } else if (self.flow == SDFPagesFlowVertical) {
            
            // Vertical
            if (self.direction == SDFPagesDirectionForward) {
                // Top to bottom
                f.origin.y = page.frame.size.height * i;
            } else {
                // Bottom to top
                f.origin.y = page.frame.size.height * (self.pages.count - 1 - i);
            }
        }
        
        page.frame = f;
		[scrollCV addSubview:page];
	}

	[self.scrollView setDocumentView:scrollCV];
	[self.contentView addSubview:self.scrollView];
}

- (void)previousPage
{
	SDFPagesDirection direction = self.direction == SDFPagesDirectionForward ? SDFPagesDirectionBackward : SDFPagesDirectionForward;
	[self changePage:direction];
}

- (void)nextPage
{
	SDFPagesDirection direction = self.direction == SDFPagesDirectionForward ? SDFPagesDirectionForward : SDFPagesDirectionBackward;
	[self changePage:direction];
}

#pragma mark - Private

/**
 *  Change the page based on whether we are going backwards or fowards (left/up or right/down)
 *
 *  @param backward Can mean either left or up
 */
- (void)changePage:(SDFPagesDirection)direction
{
    // CHECKS
    if (direction == SDFPagesDirectionBackward && self.currentPage == 0) {
        return;
    } else if (direction == SDFPagesDirectionForward && self.currentPage == self.pages.count - 1) {
        return;
    }
    
	// Source: http://stackoverflow.com/a/19676124
	[NSAnimationContext beginGrouping];
	[[NSAnimationContext currentContext] setDuration:self.animationDuration];
    
	NSClipView *clipView = [self.scrollView contentView];

	NSPoint newOrigin = clipView.bounds.origin;
    
    if (self.flow == SDFPagesFlowHorizontal) {
        if (direction == SDFPagesDirectionForward) {
            newOrigin.x += self.scrollView.contentView.frame.size.width;
        } else if (direction == SDFPagesDirectionBackward) {
            newOrigin.x -= self.scrollView.contentView.frame.size.width;
        }
    } else if (self.flow == SDFPagesFlowVertical) {
        if (direction == SDFPagesDirectionForward) {
            newOrigin.y += self.scrollView.contentView.frame.size.height;
        } else if (direction == SDFPagesDirectionBackward) {
            newOrigin.y -= self.scrollView.contentView.frame.size.height;
        }
    }

	[[clipView animator] setBoundsOrigin:newOrigin];
    
	[NSAnimationContext endGrouping];
    
    if (direction == SDFPagesDirectionBackward) {
        _currentPage --;
    } else if (direction == SDFPagesDirectionForward) {
        _currentPage ++;
    }
}

@end
