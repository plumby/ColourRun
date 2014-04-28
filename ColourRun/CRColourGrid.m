//
//  CRColourGrid.m
//  ColourRun
//
//  Created by Ian on 26/04/2014.
//  Copyright (c) 2014 Ian. All rights reserved.
//

#import "CRColourGrid.h"

@implementation CRColourGrid
@synthesize count=_count;

-(id)initWithWidth:(int)width andHeight:(int)height
{
    self=[super init];
    
    if (self) {
        _width=width;
        _height=height;
        _count=0;
        
        for (int x=0; x<width; ++x)
        {
            for (int y=0;y<height;++y)
            {
                CRColourCell* newCell=[[CRColourCell alloc]initWithX:x andY:y];
                
                _cells[x][y]=newCell;
            }
        }
    }
    
    return self;
}

-(CRColourCell*) colourAtLocationX:(int)x andY:(int)y
{
    return _cells[x][y];
}


-(void)checkSurroundingCellAtX:(int)x andY:(int)y fromColour:(int)oldColour  toColour:(int)newColour
{
    if (x>=_width ||x<0) {
        return;
    }
    
    if (y>=_height ||y<0) {
        return;
    }
    
    CRColourCell* compareCell=_cells[x][y];
    
    if (compareCell.colour==oldColour)
    {
        compareCell.colour=newColour;
        [self checkSurroundingCellsFromX:x andY:y fromColour:oldColour toColour:newColour];
    }
}


-(void)checkSurroundingCellsFromX:(int)x andY:(int)y fromColour:(int)oldColour  toColour:(int)newColour
{
    [self checkSurroundingCellAtX:x+1 andY:y fromColour:oldColour toColour:newColour];
    [self checkSurroundingCellAtX:x-1 andY:y fromColour:oldColour toColour:newColour];
    [self checkSurroundingCellAtX:x andY:y+1 fromColour:oldColour toColour:newColour];
    [self checkSurroundingCellAtX:x andY:y-1 fromColour:oldColour toColour:newColour];
}



-(void)setColour:(int)newColour
{
    CRColourCell* firstCell=_cells[0][0];
    
    int oldColour=firstCell.colour;
    
    firstCell.colour=newColour;
    
    [self checkSurroundingCellsFromX:0 andY:0 fromColour:oldColour toColour:newColour];
}




@end
