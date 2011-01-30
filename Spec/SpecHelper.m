#import "Trakt.h"
#import "Episode.h"

@interface Helper : NSObject {
}

+ (NSString *)stringFromUTF8Data:(NSData *)data;

+ (BOOL)image:(UIImage *)image1 equalToImage:(UIImage *)image2;

@end

@implementation Helper

+ (NSString *)stringFromUTF8Data:(NSData *)data {
  NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)image:(UIImage *)image1 equalToImage:(UIImage *)image2 {
  return [UIImagePNGRepresentation(image1) isEqualToData:UIImagePNGRepresentation(image2)];
}

@end


static void callNuBlockWithArguments(id nuBlock, NSArray *arguments) {
  id args = [arguments performSelector:@selector(list)];
  id context = [nuBlock performSelector:@selector(context)];
  [nuBlock performSelector:@selector(evalWithArguments:context:) withObject:args withObject:context];
}


@implementation Episode (SpecHelper)

- (void)ensureShowPosterIsLoadedWithNuBlock:(id)nuBlock {
  [self ensureShowPosterIsLoaded:^{
    callNuBlockWithArguments(nuBlock, [NSArray array]);
  }];
}

- (void)ensureThumbIsLoadedWithNuBlock:(id)nuBlock {
  [self ensureThumbIsLoaded:^{
    callNuBlockWithArguments(nuBlock, [NSArray array]);
  }];
}


@end


@implementation Trakt (SpecHelper)

- (void)calendarWithNuBlock:(id)nuBlock {
  [self calendar:^(NSArray *broadcastDates) {
    callNuBlockWithArguments(nuBlock, [NSArray arrayWithObject:broadcastDates]);
  }];
}

- (void)showPosterForTVDBId:(NSString *)tvdbID nuBlock:(id)nuBlock {
  [self showPosterForTVDBId:tvdbID block:^(UIImage *poster, BOOL cached) {
    callNuBlockWithArguments(nuBlock, [NSArray arrayWithObjects:poster, [NSNumber numberWithBool:cached], nil]);
  }];
}

- (void)showThumbForTVDBId:(NSString *)tvdbID season:(NSInteger)season episode:(NSInteger)episode nuBlock:(id)nuBlock {
  [self showThumbForTVDBId:tvdbID season:season episode:episode block:^(UIImage *thumb, BOOL cached) {
    callNuBlockWithArguments(nuBlock, [NSArray arrayWithObjects:thumb, [NSNumber numberWithBool:cached], nil]);
  }];
}

- (void)loadImageFromURL:(NSURL *)URL nuBlock:(id)nuBlock {
  [self loadImageFromURL:URL block:^(UIImage *image, BOOL cached) {
    callNuBlockWithArguments(nuBlock, [NSArray arrayWithObjects:image, [NSNumber numberWithBool:cached], nil]);
  }];
}

@end


@implementation HTTPDownload (SpecHelper)

+ (id)downloadFromURL:(NSURL *)theURL nuBlock:(id)nuBlock {
  return [self downloadFromURL:theURL block:^(id response) {
    callNuBlockWithArguments(nuBlock, [NSArray arrayWithObject:response]);
  }];
}

@end