//
//  PDFShowView.m
//  EffortlessEnglish
//
//  Created by wangyuehong on 16/8/12.
//  Copyright © 2016年 Oradt. All rights reserved.
//

#import "PDFShowView.h"

@interface PDFShowView ()

@property(nonatomic, strong) LazyPDFDocument *document;

@property(nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic, assign) NSInteger minimumPage;

@property(nonatomic, assign) NSInteger maximumPage;

@property(nonatomic, assign) NSInteger currentPage;

@property(nonatomic, strong) NSMutableDictionary *contentViews;

@end

@implementation PDFShowView

- (instancetype)initWithLazyPDFDocument:(LazyPDFDocument *)object {
    self = [super init];
    if (self) {
        [object updateDocumentProperties];
        self.document = object;
        self.minimumPage = 0;
        self.maximumPage = [self.document.pageCount integerValue];
        self.contentViews = [[NSMutableDictionary alloc] initWithCapacity:10];
        self.backgroundColor = [UIColor clearColor];

        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 50)];
        scrollView.pagingEnabled = YES;
        scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self showDocument];
}

- (void)updateContentSize:(UIScrollView *)scrollView {
    CGFloat contentHeight = scrollView.bounds.size.height;  // Height
    CGFloat contentWidth = (scrollView.bounds.size.width * self.maximumPage);

    scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
}

- (void)updateContentViews:(UIScrollView *)scrollView {
    [self updateContentSize:scrollView];  // Update content size first

    // Enumerate content views
    [self.contentViews enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, LazyPDFContentView *contentView, BOOL *stop) {
      NSInteger page = [key integerValue];  // Page number value

      CGRect viewRect = CGRectZero;
      viewRect.size = scrollView.bounds.size;
      viewRect.origin.x = (viewRect.size.width * (page - 1));  // Update X

      contentView.frame = CGRectInset(viewRect, 4.0f, 0.0f);
    }];

    NSInteger page = self.currentPage;  // Update scroll view offset to current page

    CGPoint contentOffset = CGPointMake((scrollView.bounds.size.width * (page - 1)), 0.0f);

    if (CGPointEqualToPoint(scrollView.contentOffset, contentOffset) == false) {
        scrollView.contentOffset = contentOffset;  // Update content offset
    }
}

- (void)addContentView:(UIScrollView *)scrollView page:(NSInteger)page {
    CGRect viewRect = CGRectZero;
    viewRect.size = scrollView.bounds.size;

    viewRect.origin.x = (viewRect.size.width * page);
    viewRect = CGRectInset(viewRect, 4.0f, 0.0f);

    NSURL *fileURL = self.document.fileURL;
    NSString *phrase = self.document.password;

    NSInteger showPage = page + 1;

    LazyPDFContentView *contentView =
        [[LazyPDFContentView alloc] initWithFrame:viewRect fileURL:fileURL page:showPage password:phrase];

    [self.contentViews setObject:contentView forKey:[NSNumber numberWithInteger:showPage]];
    [scrollView addSubview:contentView];
}

- (void)layoutContentViews:(UIScrollView *)scrollView {
    NSRange pageRange = NSMakeRange(self.minimumPage, self.maximumPage);

    NSMutableIndexSet *pageSet = [NSMutableIndexSet indexSetWithIndexesInRange:pageRange];

    if (pageSet.count > 0) {
        // Enumerate page set
        [pageSet enumerateIndexesWithOptions:NSEnumerationConcurrent
                                  usingBlock:^(NSUInteger page, BOOL *stop) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                      [self addContentView:scrollView page:page];
                                    });
                                  }];
    }
}

- (void)showDocumentPage:(NSInteger)page {
    if (page != self.currentPage) {
        if ((page < self.minimumPage) || (page > self.maximumPage)) {
            return;
        }

        self.currentPage = page;
        self.document.pageNumber = [NSNumber numberWithInteger:page];

        CGPoint contentOffset = CGPointMake((self.scrollView.bounds.size.width * (page - 1)), 0.0f);

        if (CGPointEqualToPoint(self.scrollView.contentOffset, contentOffset) == true) {
            [self layoutContentViews:self.scrollView];
        } else {
            [self.scrollView setContentOffset:contentOffset];
        }

        [self.contentViews enumerateKeysAndObjectsUsingBlock:  // Enumerate content views
                               ^(NSNumber *key, LazyPDFContentView *contentView, BOOL *stop) {
                                 if ([key integerValue] != page) [contentView zoomResetAnimated:NO];
                               }];
    }
}

- (void)showDocument {
    [self updateContentSize:self.scrollView];  // Update content size first

    [self showDocumentPage:[self.document.pageNumber integerValue]];  // Show page
}

@end
