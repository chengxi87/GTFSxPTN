function [name,coord] = getStopInfo(Stops,stopID)

idx = find([Stops.ID] == stopID);
name = Stops(idx).name;
coord = [Stops(idx).x,Stops(idx).y];

end