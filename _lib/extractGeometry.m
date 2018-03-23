function geometry = extractGeometry(oStop,dStop,Stops,shapeCoords)

[~,oStopCoord] = getStopInfo(Stops,oStop);

distances = sqrt(sum(bsxfun(@minus, shapeCoords, oStopCoord).^2,2));
sr = find(distances==min(distances));

[~,dStopCoord] = getStopInfo(Stops,dStop);
distances = sqrt(sum(bsxfun(@minus, shapeCoords, dStopCoord).^2,2));
er = find(distances==min(distances));

geometry = shapeCoords(sr:er,:);

end