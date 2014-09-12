//
//  SDFPagesController.h
//  SDFPages
//
//  Created by Trent Milton on 10/09/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDFPageController;

typedef enum
{
    SDFPagesFlowHorizontal=0,
    SDFPagesFlowVertical
} SDFPagesFlow;

typedef enum
{
    SDFPagesDirectionForward=0,
    SDFPagesDirectionBackward
} SDFPagesDirection;

@interface SDFPagesController : NSObject

/**
 *  Must be of type SDFPageController
 */
@property (nonatomic, strong) NSArray *pages;
/**
 *  Will containt all the views from the pages laid out in the direction
 */
@property (nonatomic, strong) NSScrollView *scrollView;
/**
 *  The view to which the scrollView will be added.
 */
@property (nonatomic, weak) NSView *contentView;
/**
 *  How the pages will be aligned next to each other.
 *
 *  Default: SDFPagesFlowHorizontal
 */
@property (nonatomic) SDFPagesFlow flow;
/**
 *  Specify a direction that the tutorial will flow.
 *
 *  Default: SDFPagesDirection
 */
@property (nonatomic) SDFPagesDirection direction;
/**
 *  Animation duration in seconds
 *
 *  Default: 2 seconds
 */
@property (nonatomic) CGFloat animationDuration;
/**
 *  Current page being display, will only be update after an animation. 0 based index.
 */
@property (nonatomic, readonly) int currentPage;

/**
 *  When called all the pages views will be added to the scrollView and the scroll view will be added to the contentView. This is left up to you to allow freedom in when it's setup and also give you time to set the properties above. This can only be called once, you will need a new instance if you want to call it again.
 *
 *  If you want to use addPageAndNavigateTo make sure you only pass in the pages you want to navigate through linearly before you start doing some branching. As this method will go an add all the pages next to each other and the addPageAndNavigateTo will just add it to the end you will have issues if you call addPageAndNavigateTo if you aren't at the end of the passed in pages.
 */
- (void)setup;
/**
 *  This allows some more freedom in the page controller, you can add a page and then navigate directly to it. You should only call this when you are at the end of the previously passed in pages, otherwise odd things can and most likely will happen.
 *
 *  @param pageController Page controller to add to the end of the scroll view
 */
- (void)addPageAndNavigateTo:(SDFPageController *)pageController;
- (void)previousPage;
- (void)nextPage;


@end
