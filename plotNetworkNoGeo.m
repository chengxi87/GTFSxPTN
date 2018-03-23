function plotNetworkNoGeo(Links,Stops)

% define the best scale of graph
nb = max([Stops.y]);
sb = min([Stops.y]);
wb = min([Stops.x]);
eb = max([Stops.x]);

nLinks = length(Links);
for iLink = 1:nLinks
    oStop = Links(iLink).oStop;
    dStop = Links(iLink).dStop;

    oX = Stops(findRowID(oStop,Stops)).x;
    oY = Stops(findRowID(oStop,Stops)).y;
    dX = Stops(findRowID(dStop,Stops)).x;
    dY = Stops(findRowID(dStop,Stops)).y; 
    
    plot([oX dX],[oY dY],'-','Color',[.3 .3 .3]);
    hold on;
end

x = [Stops.x];y = [Stops.y];
scatter(x,y,5,'r','filled');

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

xlim([wb,eb]);
ylim([sb,nb]);
axis off;

end


function rowID = findRowID(stopID,Stops)
rowID = find([Stops.ID] == stopID); 
end