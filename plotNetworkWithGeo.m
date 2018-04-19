function plotNetworkWithGeo(Links,Stops)

linkcolor = [0 0.447058826684952 0.74117648601532];
nodecolor = [0.0784313753247261 0.168627455830574 0.549019634723663];

for i = 1:length(Links)
    geometry = Links(i).geometry;
    lh = plot(geometry(:,1),geometry(:,2));
    lh.Color = linkcolor;
    lh.LineWidth = 0.5;
    hold on;
end

% plot stops
for i = 1:length(Stops)
    curX = Stops(i).x;
    curY = Stops(i).y;
    plot(curX,curY,'o','MarkerSize',1.5,...
        'MarkerFaceColor',nodecolor,...
        'MarkerEdgeColor',nodecolor);
    hold on;
%     text(curX,curY,Stops(i).name,'FontSize',8);
%     hold on;
end


X = [Stops.x];
Y = [Stops.y];
theta = 0.0008;
xlim([min(X)-theta max(X)+theta]);
ylim([min(Y)-theta max(Y)+theta]);
axis off;

set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.005 .005] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'XColor'      , [.1 .1 .1], ...
  'YColor'      , [.1 .1 .1], ...
  'FontName'    ,'Times New Roman',...
  'FontWeight', 'bold',...
  'FontSize'    , 8,...
  'LineWidth'   , 0.5         );

set(gcf,'Position',[100 100 300 300]);
set(gca,'Position',[.13 .17 .80 .74]);

end