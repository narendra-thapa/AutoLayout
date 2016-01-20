//
//  LPAViewController.m
//  Autolayout
//
//  Created by Steven Masuch on 2014-07-20.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPAViewController.h"

@interface LPAViewController ()

@property (nonatomic, weak) UIButton *  squareButton;
@property (nonatomic, weak) UIButton *  portraitButton;
@property (nonatomic, weak) UIButton *  landscapeButton;

@property (nonatomic, weak) UIButton *  yellowButton;
@property (nonatomic) NSUInteger yellowCounter;
@property (nonatomic) UIView *yellowRectangle;

@property (nonatomic) NSLayoutConstraint *purpleRectangleBottom;


@property (nonatomic) UIView *purpleRectangle;
@property (nonatomic) NSLayoutConstraint *yellowRectangleBottom;

@property (nonatomic) NSLayoutConstraint *blueSquareOneYPosition;
@property (nonatomic) NSLayoutConstraint *blueSquareTwoYPosition;
@property (nonatomic) NSLayoutConstraint *blueSquareThreeYPosition;

@property (nonatomic, weak) UIView *                framingView;
@property (nonatomic, weak) NSLayoutConstraint *    framingViewHeight;
@property (nonatomic, weak) NSLayoutConstraint *    framingViewWidth;


@end

@implementation LPAViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _yellowCounter = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *squareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [squareButton setTitle:@"Square" forState:UIControlStateNormal];
    [squareButton addTarget:self action:@selector(resizeFramingView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:squareButton];
    squareButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.squareButton = squareButton;
    
    UIButton *portraitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [portraitButton setTitle:@"Portrait" forState:UIControlStateNormal];
    [portraitButton addTarget:self action:@selector(resizeFramingView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:portraitButton];
    portraitButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.portraitButton = portraitButton;
    
    UIButton *landscapeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [landscapeButton setTitle:@"Landscape" forState:UIControlStateNormal];
    [landscapeButton addTarget:self action:@selector(resizeFramingView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landscapeButton];
    landscapeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.landscapeButton = landscapeButton;
    
    UIButton *yellowButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [yellowButton setTitle:@"Show/Hide Yellow" forState:UIControlStateNormal];
    [yellowButton addTarget:self action:@selector(showHideYellowRectangle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yellowButton];
    yellowButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.yellowButton = yellowButton;
    



    UIView *framingView = [[UIView alloc] initWithFrame:CGRectZero];
    framingView.translatesAutoresizingMaskIntoConstraints = NO;
    framingView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:framingView];
    self.framingView = framingView;
    
    NSString *buttonsHorizontalConstraints = @"|[squareButton(==portraitButton)][portraitButton(==landscapeButton)][landscapeButton(==yellowButton)][yellowButton]|";
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:buttonsHorizontalConstraints
                                                                      options:NSLayoutFormatAlignAllCenterY
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(squareButton, portraitButton, landscapeButton, yellowButton)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:squareButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-50.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:framingView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:framingView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:-50.0]];
    
    NSLayoutConstraint *framingViewHeight = [NSLayoutConstraint constraintWithItem:framingView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:500.0];
    
    NSLayoutConstraint *framingViewWidth = [NSLayoutConstraint constraintWithItem:framingView
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:500.0];
    
    [framingView addConstraint:framingViewHeight];
    [framingView addConstraint:framingViewWidth];
    
    self.framingViewHeight = framingViewHeight;
    self.framingViewWidth = framingViewWidth;
    
    // Yello Rectangle
    self.yellowRectangle = [[UIView alloc] initWithFrame:CGRectZero];
    self.yellowRectangle.translatesAutoresizingMaskIntoConstraints = NO;
    self.yellowRectangle.backgroundColor = [UIColor yellowColor];
    [self.framingView addSubview:self.yellowRectangle];
    self.yellowRectangle.hidden = YES;
    
    NSLayoutConstraint *yellowRectangleWidth = [NSLayoutConstraint constraintWithItem:self.yellowRectangle
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.framingView
                                                                            attribute:NSLayoutAttributeWidth
                                                                           multiplier:1
                                                                             constant:0];
    
    NSLayoutConstraint *yellowRectangleHeight = [NSLayoutConstraint constraintWithItem:self.yellowRectangle
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0
                                                                              constant:150.0];
    
    self.yellowRectangleBottom = [NSLayoutConstraint constraintWithItem:self.yellowRectangle
                                                                             attribute:NSLayoutAttributeBottom
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.framingView
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:150];
    
    NSLayoutConstraint *yellowRectangleLeft = [NSLayoutConstraint constraintWithItem:self.yellowRectangle
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.framingView
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1.0
                                                                            constant:0];
    [self.framingView addConstraint:yellowRectangleWidth];
    [self.framingView addConstraint:yellowRectangleHeight];
    [self.framingView addConstraint:self.yellowRectangleBottom];
    [self.framingView addConstraint:yellowRectangleLeft];
    
    // Purple Rectangle
    
    self.purpleRectangle = [[UIView alloc] initWithFrame:CGRectZero];
    self.purpleRectangle.translatesAutoresizingMaskIntoConstraints = NO;
    self.purpleRectangle.backgroundColor = [UIColor purpleColor];
    [self.framingView addSubview:self.purpleRectangle];
    
    NSLayoutConstraint *purpleRectangleWidth = [NSLayoutConstraint constraintWithItem:self.purpleRectangle
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.framingView
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:0.61
                                                                             constant:0];
    
    NSLayoutConstraint *purpleRectangleHeight = [NSLayoutConstraint constraintWithItem:self.purpleRectangle
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:50.0];
    
    self.purpleRectangleBottom = [NSLayoutConstraint constraintWithItem:self.purpleRectangle
                                                                             attribute:NSLayoutAttributeBottom
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.yellowRectangle
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:-170];

    NSLayoutConstraint *purpleRectangleRight = [NSLayoutConstraint constraintWithItem:self.purpleRectangle
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.framingView
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1.0
                                                                              constant:-20];
    
    [self.framingView addConstraint:purpleRectangleWidth];
    [self.framingView addConstraint:purpleRectangleHeight];
    [self.framingView addConstraint:purpleRectangleRight];
    [self.framingView addConstraint:self.purpleRectangleBottom];
    
    // Blue Boxes
    
    UIView *blueSquareOne = [[UIView alloc] initWithFrame:CGRectZero];
    blueSquareOne.translatesAutoresizingMaskIntoConstraints = NO;
    blueSquareOne.backgroundColor = [UIColor blueColor];
    [self.framingView addSubview:blueSquareOne];
    
    NSLayoutConstraint *blueSquareOneWidth = [NSLayoutConstraint constraintWithItem:blueSquareOne
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1
                                                                             constant:50];
    
    NSLayoutConstraint *blueSquareOneHeight = [NSLayoutConstraint constraintWithItem:blueSquareOne
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0
                                                                              constant:50.0];
    
    NSLayoutConstraint *blueSquareOneXPosition = [NSLayoutConstraint constraintWithItem:blueSquareOne
                                                                           attribute:NSLayoutAttributeCenterX
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.framingView
                                                                           attribute:NSLayoutAttributeCenterX
                                                                          multiplier:1.0
                                                                            constant:0.0];
    
    self.blueSquareOneYPosition = [NSLayoutConstraint constraintWithItem:blueSquareOne
                                                                              attribute:NSLayoutAttributeCenterY
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.framingView
                                                                              attribute:NSLayoutAttributeCenterY
                                                                             multiplier:1.0
                                                                               constant:0];
    
    [self.framingView addConstraint:blueSquareOneWidth];
    [self.framingView addConstraint:blueSquareOneHeight];
    [self.framingView addConstraint:blueSquareOneXPosition];
    [self.framingView addConstraint:self.blueSquareOneYPosition];
    
    UIView *blueSquareTwo = [[UIView alloc] initWithFrame:CGRectZero];
    blueSquareTwo.translatesAutoresizingMaskIntoConstraints = NO;
    blueSquareTwo.backgroundColor = [UIColor blueColor];
    [self.framingView addSubview:blueSquareTwo];
    
    NSLayoutConstraint *blueSquareTwoWidth = [NSLayoutConstraint constraintWithItem:blueSquareTwo
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:50];
    
    NSLayoutConstraint *blueSquareTwoHeight = [NSLayoutConstraint constraintWithItem:blueSquareTwo
                                                                           attribute:NSLayoutAttributeHeight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0
                                                                            constant:50.0];
    
    NSLayoutConstraint *blueSquareTwoXPosition = [NSLayoutConstraint constraintWithItem:blueSquareTwo
                                                                              attribute:NSLayoutAttributeCenterX
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.framingView
                                                                              attribute:NSLayoutAttributeCenterX
                                                                             multiplier:1.0
                                                                               constant:0.0];
    
    self.blueSquareTwoYPosition = [NSLayoutConstraint constraintWithItem:blueSquareTwo
                                                                              attribute:NSLayoutAttributeCenterY
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.framingView
                                                                              attribute:NSLayoutAttributeCenterY
                                                                             multiplier:0.5
                                                                               constant:0.0];
    [self.framingView addConstraint:blueSquareTwoWidth];
    [self.framingView addConstraint:blueSquareTwoHeight];
    [self.framingView addConstraint:blueSquareTwoXPosition];
    [self.framingView addConstraint:self.blueSquareTwoYPosition];
    
    UIView *blueSquareThree = [[UIView alloc] initWithFrame:CGRectZero];
    blueSquareThree.translatesAutoresizingMaskIntoConstraints = NO;
    blueSquareThree.backgroundColor = [UIColor blueColor];
    [self.framingView addSubview:blueSquareThree];
    
    NSLayoutConstraint *blueSquareThreeWidth = [NSLayoutConstraint constraintWithItem:blueSquareThree
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:50];
    
    NSLayoutConstraint *blueSquareThreeHeight = [NSLayoutConstraint constraintWithItem:blueSquareThree
                                                                           attribute:NSLayoutAttributeHeight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0
                                                                            constant:50.0];
    
    NSLayoutConstraint *blueSquareThreeXPosition = [NSLayoutConstraint constraintWithItem:blueSquareThree
                                                                              attribute:NSLayoutAttributeCenterX
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.framingView
                                                                              attribute:NSLayoutAttributeCenterX
                                                                             multiplier:1.0
                                                                               constant:0.0];
    
    self.blueSquareThreeYPosition = [NSLayoutConstraint constraintWithItem:blueSquareThree
                                                                              attribute:NSLayoutAttributeCenterY
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.framingView
                                                                              attribute:NSLayoutAttributeCenterY
                                                                             multiplier:1.5
                                                                               constant:0.0];

    [self.framingView addConstraint:blueSquareThreeWidth];
    [self.framingView addConstraint:blueSquareThreeHeight];
    [self.framingView addConstraint:blueSquareThreeXPosition];
    [self.framingView addConstraint:self.blueSquareThreeYPosition];
    
    // Red box
    
    UIView *redRectangle = [[UIView alloc] initWithFrame:CGRectZero];
    redRectangle.translatesAutoresizingMaskIntoConstraints = NO;
    redRectangle.backgroundColor = [UIColor redColor];
    [self.framingView addSubview:redRectangle];
    
    NSLayoutConstraint *redRectangleWidth = [NSLayoutConstraint constraintWithItem:redRectangle
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1
                                                                             constant:150];
    
    NSLayoutConstraint *redRectangleHeight = [NSLayoutConstraint constraintWithItem:redRectangle
                                                                             attribute:NSLayoutAttributeHeight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0
                                                                              constant:50.0];

    NSLayoutConstraint *redRectangleTop = [NSLayoutConstraint constraintWithItem:redRectangle
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.framingView
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0
                                                                              constant:20];
    
    NSLayoutConstraint *redRectangleRight = [NSLayoutConstraint constraintWithItem:redRectangle
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.framingView
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0
                                                                             constant:-20];
    [self.framingView addConstraint:redRectangleWidth];
    [self.framingView addConstraint:redRectangleHeight];
    [self.framingView addConstraint:redRectangleTop];
    [self.framingView addConstraint:redRectangleRight];
    
    // Orange Boxes within Red box
    
    UIView *orangeRectangleOne = [[UIView alloc] initWithFrame:CGRectZero];
    orangeRectangleOne.translatesAutoresizingMaskIntoConstraints = NO;
    orangeRectangleOne.backgroundColor = [UIColor orangeColor];
    [redRectangle addSubview:orangeRectangleOne];
    
    NSLayoutConstraint *orangeRectangleOneWidth = [NSLayoutConstraint constraintWithItem:orangeRectangleOne
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:70];
    
    NSLayoutConstraint *orangeRectangleOneHeight = [NSLayoutConstraint constraintWithItem:orangeRectangleOne
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1.0
                                                                           constant:30.0];
    
    NSLayoutConstraint *orangeRectangleOneTop = [NSLayoutConstraint constraintWithItem:orangeRectangleOne
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:redRectangle
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1.0
                                                                        constant:10];
    
    NSLayoutConstraint *orangeRectangleOneLeft = [NSLayoutConstraint constraintWithItem:orangeRectangleOne
                                                                         attribute:NSLayoutAttributeLeft
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:redRectangle
                                                                         attribute:NSLayoutAttributeLeft
                                                                        multiplier:1.0
                                                                          constant:10];
    [redRectangle addConstraint:orangeRectangleOneWidth];
    [redRectangle addConstraint:orangeRectangleOneHeight];
    [redRectangle addConstraint:orangeRectangleOneTop];
    [redRectangle addConstraint:orangeRectangleOneLeft];
    
    UIView *orangeRectangleTwo = [[UIView alloc] initWithFrame:CGRectZero];
    orangeRectangleTwo.translatesAutoresizingMaskIntoConstraints = NO;
    orangeRectangleTwo.backgroundColor = [UIColor orangeColor];
    [redRectangle addSubview:orangeRectangleTwo];
    
    NSLayoutConstraint *orangeRectangleTwoWidth = [NSLayoutConstraint constraintWithItem:orangeRectangleTwo
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:50];
    
    NSLayoutConstraint *orangeRectangleTwoHeight = [NSLayoutConstraint constraintWithItem:orangeRectangleTwo
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:30.0];
    
    NSLayoutConstraint *orangeRectangleTwoTop = [NSLayoutConstraint constraintWithItem:orangeRectangleTwo
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:redRectangle
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1.0
                                                                           constant:10];
    
    NSLayoutConstraint *orangeRectangleTwoLeft = [NSLayoutConstraint constraintWithItem:orangeRectangleTwo
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:redRectangle
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:-10];
    [redRectangle addConstraint:orangeRectangleTwoWidth];
    [redRectangle addConstraint:orangeRectangleTwoHeight];
    [redRectangle addConstraint:orangeRectangleTwoTop];
    [redRectangle addConstraint:orangeRectangleTwoLeft];
    
}

- (void)resizeFramingView:(id)sender
{
    CGFloat newWidth = 0.0;
    CGFloat newHeight = 0.0;
    
    if (sender == self.squareButton) {
        newWidth = 500.0;
        newHeight = 500.0;
    } else if (sender == self.portraitButton) {
        newWidth = 350.0;
        newHeight = 550.0;
    } else if (sender == self.landscapeButton) {
        newWidth = 900.0;
        newHeight = 300.0;
    }
    
    [UIView animateWithDuration:2.0 animations:^(){
        self.framingViewHeight.constant = newHeight;
        self.framingViewWidth.constant = newWidth;
        [self.view layoutIfNeeded];
    }];
}

- (void)showHideYellowRectangle:(id)sender {
    if ((self.yellowCounter % 2) != 0) {
        
        self.yellowRectangleBottom.constant = 150;
        self.blueSquareTwoYPosition.constant = 0;
        self.blueSquareOneYPosition.constant = 0;
        self.blueSquareThreeYPosition.constant = 0;
        NSLog(@"Yes");
//        [self.view layoutIfNeeded];
        [UIView animateWithDuration:1 animations:^{
            [self.view layoutIfNeeded];
        }];
        self.yellowRectangle.hidden = YES;
        self.yellowCounter++;
        
    } else {
        self.yellowRectangleBottom.constant = 0;
        if (self.framingViewHeight.constant != 300.0) {
        self.blueSquareTwoYPosition.constant = -37.5;
        self.blueSquareOneYPosition.constant = -75;
            self.blueSquareThreeYPosition.constant = -112.5;}
        NSLog(@"No");
//        [self.view layoutIfNeeded];
        [UIView animateWithDuration:1 animations:^{
            [self.view layoutIfNeeded];
        }];
        self.yellowRectangle.hidden = NO;
        self.yellowCounter++;
    }
}

@end
