function lh = plotNetworkWithGeo(Links,Stops)

for i = 1:length(Links)
    geometry = Links(i).geometry;
    lh = plot(geometry(:,1),geometry(:,2));
    lh.Color = 'k';
    lh.LineWidth = 1;
    hold on;
end

% plot stops
for i = 1:length(Stops)
    curX = Stops(i).x;
    curY = Stops(i).y;
    lh = plot(curX,curY,'o','MarkerSize',2,...
        'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
end

end