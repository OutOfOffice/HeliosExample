//
//  PDCPhotoViewController.m
//  SimpleFlickr
//
//  Created by koba on 8/12/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//

#import "PhotoViewController.h"
#import "AFNetworking.h"

@interface PhotoViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation PhotoViewController

- (void)setTitle:(NSString *)title
{
    super.title = title;
}

- (void)setPhoto:(Photo *)photo
{
    _photo = photo;
    [self resetImage];
}

- (void)resetImage
{
    if (self.scrollView) {
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
        [self.imageView removeFromSuperview];
        
        [self.imageView setImageWithURL:[NSURL URLWithString:self.photo.imageURL] placeholderImage:[UIImage imageNamed:@"731-cloud-download"]];
        self.scrollView.zoomScale = 1.0;
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.scrollView addSubview:self.imageView];
        
        NSDictionary *viewsDictionary = @{@"imageView":self.imageView};
        [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:0 metrics:nil views:viewsDictionary]];
        [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics:nil views:viewsDictionary]];
    }
}

- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 5.0;
    [self resetImage];
}

@end
