%SetFigSize.m
%Code to set up the figure dimensions
%may be used as a function
FigureWidth = 10;
FigureHeight = 4.5;
set(gcf, 'Units', 'Inches');
set(gcf, 'Position', [2.5,2.5,FigureWidth, FigureHeight]);
FigureLeftMargin = 1;
FigureBottomMargin = 1;
FigureMargin = .75;
set(gca, 'Units', 'Inches');
set(gca, 'Position',[FigureLeftMargin,...
 FigureBottomMargin,...
FigureWidth-FigureMargin-FigureLeftMargin,...
 FigureHeight-FigureMargin-FigureBottomMargin]);