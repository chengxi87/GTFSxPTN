function plotNetworkNoGeo(Links,Stops,textOn)

linkcolor = [0 0.447058826684952 0.74117648601532];
nodecolor = [0.0784313753247261 0.168627455830574 0.549019634723663];

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
    
    plot([oX dX],[oY dY],'-','Color',linkcolor);
    hold on;
end

for i = 1:length(Stops)
    curX = Stops(i).x;
    curY = Stops(i).y;
    plot(curX,curY,'o','MarkerSize',3,...
        'MarkerFaceColor',nodecolor,...
        'MarkerEdgeColor',nodecolor);
    hold on;
    if textOn
        text(curX,curY,Stops(i).name,'FontSize',8);
        hold on;
    end 
end

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