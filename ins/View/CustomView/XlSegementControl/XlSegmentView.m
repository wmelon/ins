 

#import "XlSegmentView.h"

#define WIDTH 5
#define HEIGHT 30

@interface XlSegmentView ()
{
    UIImageView * _imageView;
    UILabel * _titleLabel;
    UIImage * _image;
    UIImage * _highlineImage;
    UIColor * _textColor;
    UIColor * _highlineTextColor;
}

@end

@implementation XlSegmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    _titleLabel.font = _font;
}

-(void)setText:(NSString *)text
{
    _text = text;
    _titleLabel.text = text;
}

-(void)setLableTextColor:(UIColor *)color highlineColor:(UIColor *)highlineColor
{
    _textColor = color;
    _highlineTextColor = highlineColor;
    _titleLabel.textColor = _textColor;
}

-(void)setImage:(UIImage *)image highlineImage:(UIImage *)highlineImage
{
    _image = image;
    _highlineImage = highlineImage;
    _imageView.image = _image;
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    if(!_selected){
        _imageView.image = _image;
        _titleLabel.textColor = _textColor;
    }else{
        if(_highlineImage){
            _imageView.image = _highlineImage;
        }else{
            _imageView.image = _image;
        }
        _titleLabel.textColor = _highlineTextColor;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = [self getSizeOfContent:_titleLabel.text];
    
    CGFloat x = (self.frame.size.width - size.width - HEIGHT - WIDTH )/2;
    _imageView.frame = CGRectMake(x, (self.frame.size.height - HEIGHT)/2, HEIGHT, HEIGHT);
    if(_image){
        _titleLabel.frame = CGRectMake(x + HEIGHT + WIDTH, 0, self.frame.size.width - HEIGHT - WIDTH - x, self.frame.size.height);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }else{
        _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

-(CGSize)getSizeOfContent:(NSString *)str {
    CGSize size = CGSizeMake(self.frame.size.width,CGFLOAT_MAX);
    UIFont *tfont = _font;
    
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize  actualsize = CGSizeMake(0, 0);
    if(ISIos7){
        actualsize =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    }
//    else if (IOS7Below){
//        actualsize = [str sizeWithFont:tfont constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//    }
//    
    return actualsize;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
