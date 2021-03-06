% [Project]        [M3X] Whip Project
% [Title]          Script for generating the images 
% [Author]         Moses C. Nah
% [Creation Date]  Monday, June 4th, 2021
%
% [Emails]         Moses C. Nah   : mosesnah@mit.edu
%% (--) INITIALIZATION

clear all; close all; clc; workspace;

cd( fileparts( matlab.desktop.editor.getActiveFilename ) );                % Setting the current directory (cd) as the current location of this folder. 
addpath( './myGraphics' ); addpath( './myUtils' ); 
myFigureConfig( 'fontsize', 25, ...
               'lineWidth', 3, ...
              'markerSize', 25    )  
             
global c                                                                   % Setting color structure 'c' as global variable
c  = myColor();            


%% ==================================================================
%% (1-) Running State Simulation
%% -- (1A) For second-order system.

A = [0, 1; -4,  -4];
[ V,D ] = eig( A );

x0 = [-3; 2];

tVec = 0 : 0.01 : 7;
N    = length( tVec );
x    = zeros( 2, length( tVec ) );

for i = 1 : N
    x( :, i ) = expm( A * tVec( i ) ) * x0;
end

clear gObjs


% For the target of the model
gObjs(  1 ) = myMarker( 'XData', x( 1, :  ) , ... 
                        'YData', x( 2, :  ) , ... 
                        'ZData', zeros( 1, N ) , ... 
                         'name', "state"  , ...
                     'SizeData',  500      , ...
                    'LineWidth',   1       , ...
              'MarkerEdgeColor',   [1,0,0] , ...
              'MarkerFaceColor',   [1,0,0] , ...
              'MarkerFaceAlpha', 0.8       );                              % Defining the markers for the plot

          
ani = myAnimation( tVec( 2 ), gObjs );                        

plot( ani.hAxes{ 1 },   x(1 , : ),   x( 2 , : ), 'linestyle', '-', 'color', 'k', 'linewidth', 4, 'markersize', 3 )

scatter( ani.hAxes{ 1 }, x(1 , 1 ), x( 2 , 1 ), 300, 'o', 'markeredgecolor', c.blue, 'markerfacecolor', c.blue, 'markerfacealpha', 0.8 )
scatter( ani.hAxes{ 1 },         0,          0, 300, 'o', 'markeredgecolor', c.blue, 'markerfacecolor', c.blue, 'markerfacealpha', 0.8 )

tmpLim = 7;
tmpX = -tmpLim: 0.1 :tmpLim;

% plot( ani.hAxes{ 1 }, tmpX ,      tmpX * V(1,1)/V(2,1), 'linestyle', '--', 'color', [0.5, 0.5, 0.5] , 'linewidth', 3 )
% plot( ani.hAxes{ 1 }, tmpX ,  6 + tmpX * V(1,1)/V(2,1), 'linestyle', '--', 'color', [0.5, 0.5, 0.5] , 'linewidth', 3 )
% plot( ani.hAxes{ 1 }, tmpX , -6 + tmpX * V(1,1)/V(2,1), 'linestyle', '--', 'color', [0.5, 0.5, 0.5] , 'linewidth', 3 )
% 
% plot( ani.hAxes{ 1 }, tmpX ,      tmpX * V(1,2)/V(2,2), 'linestyle', '--', 'color', [0.5, 0.5, 0.5] , 'linewidth', 3 )


ani.adjustFigures( 2 );     
plot( ani.hAxes{ 2 }, tVec , x( 1, : ) , 'linestyle', '-', 'color', c.black , 'linewidth', 3 )
plot( ani.hAxes{ 2 }, tVec , x( 2, : ) , 'linestyle', '-', 'color', c.black , 'linewidth', 3 )


set( ani.hAxes{ 1 }, 'XLim',   [ -tmpLim , tmpLim ] , ...                  
                     'YLim',   [ -tmpLim , tmpLim ] , ...    
                     'view',   [0, 90]   )                

set( ani.hAxes{ 1 }, 'LineWidth', 1.4 )
xlabel( ani.hAxes{ 1 }, 'x_1' )
ylabel( ani.hAxes{ 1 }, 'x_2' )
% 
tmp1 = myMarker( 'XData', tVec , 'YData', x( 1, : ) , 'ZData', zeros( 1, N ), 'SizeData',  400, 'LineWidth', 6 ); 
tmp2 = myMarker( 'XData', tVec , 'YData', x( 2, : ) , 'ZData', zeros( 1, N ), 'SizeData',  400, 'LineWidth', 6, 'MarkerEdgeColor', c.orange ); 

xlim( ani.hAxes{ 2 }, [ 0, max( tVec ) ] )

ani.addTrackingPlots( 2, tmp1 );
ani.addTrackingPlots( 2, tmp2 );

ani.run( 0.5, 2.5, true, 'output' )
