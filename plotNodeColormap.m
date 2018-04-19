function plotNodeColormap(Stops,Links,data,titleText,colormapmat)
figure;
X = [Stops.x];
Y = [Stops.y];

plotLinks(Stops,Links);

for i = 1:length(Stops)
    val = data(i);
    perc = val/max(data);
    row = round(perc * size(colormapmat,1));
    if row == 0
        row = 1;
    end
    color = colormapmat(row,:);
    plot(Stops(i).x,Stops(i).y,'o','MarkerEdgeColor',color,...
        'MarkerFaceColor',color,'MarkerSize',3);
    hold on;
end
colormap(colormapmat);
% colorbar('SouthOutside');

title(titleText,'FontWeight','bold','FontName','Times New Roman','FontSize',9);

xlim([min(X) max(X)]);
ylim([min(Y) max(Y)+0.005]);
axis off;

set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.005 .005] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'XColor'      , [.1 .1 .1], ...
  'YColor'      , [.1 .1 .1], ...
  'FontWeight', 'bold',...
  'FontSize'    , 8,...
  'LineWidth'   , 0.5);

set(gcf,'Position',[100 100 300 300]);
set(gca,'Position',[.13 .17 .80 .74]);

end

%%
function plotLinks(Stops,Links)

for i = 1:length(Links)
    oX = Stops(Links(i).oStop).x;
    oY = Stops(Links(i).oStop).y;
    dX = Stops(Links(i).dStop).x;
    dY = Stops(Links(i).dStop).y;
    plot([oX dX],[oY dY],'-','Color','b');
    hold on;
end
end