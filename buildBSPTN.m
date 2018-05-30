function [Routes,Stops,Links] = buildBSPTN(gtfsTables,date,routeTypeList)
%%
% Description
% -----------
% This function builds the so-called Bottom Scale Public Transport Network
% (BSPTN) using the loaded GTFS data. It extracts the PTN based on the 
% that a PTN consists of routes, stops and links. The generation is based 
% on a one-day operational schedule.
%
% Parameters
% ----------
% gtfsTable: MATLAB 'table' 
%   This variable is the output of the preceding function "loadGTFS.m"
% date: string 'YYYYMMDD'
%   This is to specify which day's timetable is going to be used to extract
%   the PTN information
% routeTypeList: int array
%   This input corresponds to the GTFS standard on the 'routes'
%   0 - Tram, Streetcar, Light rail. Any light rail or street level system 
%       within a metropolitan area.
%   1 - Subway, Metro. Any underground rail system within a metropolitan area.
%   2 - Rail. Used for intercity or long-distance travel.
%   3 - Bus. Used for short- and long-distance bus routes.
%   4 - Ferry. Used for short- and long-distance boat service.
%   5 - Cable car. Used for street-level cable cars where the cable runs 
%       beneath the car.
%   6 - Gondola, Suspended cable car. Typically used for aerial cable cars
%       where the car is suspended from the cable.
%   7 - Funicular. Any rail system designed for steep inclines.
%
% Returns
% -------
% Routes: struct
%   routeID (string): unique ID for the route
%   dirID (int): value of 1 or 0 to identify the direction of the route
%   destinaiton (string) - destination name of this route
%   type (int): route type id as specified above
%   stops (int array): the sequence of stop IDs for this route. The detail
%                      of the stop is contained in 'Stops'.
%   links (int array): the sequence of link IDs for this route. The detail 
%                      of the link is contained in 'Links'.
% Stops: struct
%   ID (int): unique index for each stop. At this scale, the ID is
%             identical to the GTFS stop ID.
%   name (string): stop name obtained from the GTFS data.
%   x (float): longitude of the stop.
%   y (float): latitude of the stop.
%
% Links: struct
%   ID (int): unique index for each link. A link is defined by a pair of 
%             stop IDs from the 'Stops'.
%   oStop (int): source, or the orgin stop ID of the link.
%   dStop (int): target, or the destination stop ID of the link.
%   geometry (float array): shape of the link determined by an array of
%                           coordinates. Extracted from the GTFS data.

%% path handling
curFolderPath = fileparts(which('buildBSPTN.m'));
libPath = [curFolderPath,'\_lib'];
addpath(libPath);
%% Get all tables
routesTable = getTable('routes',gtfsTables);
tripsTable = getTable('trips',gtfsTables);
calendardatesTable = getTable('calendar_dates',gtfsTables);
stoptimesTable = getTable('stop_times',gtfsTables);
stopsTable = getTable('stops',gtfsTables);
shapesTable = getTable('shapes',gtfsTables);
% stopsTable = getTable('stops',gtfsTables); % no use in this script
% shapesTable = getTable('shapes',gtfsTables); % no use in this script
clear gtfsTables;
% convert stoptimes to make the process faster
stoptimes = table2cell(stoptimesTable);
clear stoptimesTable;

%%
Routes = struct('routeID',[],'dirID',[],'destination',[],...
    'type',[],'stops',[],'links',[]);
Stops = struct('ID',[],'name',[],'x',[],'y',[]);
Links = struct('ID',[],'oStop',[],'dStop',[],'geometry',[]);

nRoutes = 0;
nStops = 0;
nLinks = 0;

% get all the service IDs from the date
serviceIdList = getServiceIdList(calendardatesTable,date);

startRow = 1; % start row can be adjusted to save time
for k = startRow:size(routesTable,1)
    curRouteType = routesTable.route_type(k);
    if ~ismember(curRouteType,routeTypeList)
        continue;
    end
    
    routeID = routesTable.route_id(k);
    try
        % fetch all the trips of the current route ID
        tripList = getTripList(tripsTable,routeID,serviceIdList);
        % find unique directions of this route
        dirIdList = unique(cell2mat(tripList(:,4)))';
        
        for dirID = dirIdList
            nRoutes = nRoutes + 1;
            % get full stop sequence of current Route
            [fullStopSequence,finalTripDes,finalShapeID] = ...
                findFullStopSequence(dirID,tripList,stoptimes);
            
            Routes(nRoutes).routeID = char(routeID);
            Routes(nRoutes).dirID = dirID;
            Routes(nRoutes).destination = finalTripDes;
            Routes(nRoutes).type = curRouteType;
            
            % build Stops
            Routes(nRoutes).stops = [];
            for i = 1:size(fullStopSequence,1)
                val = fullStopSequence{i,1};
                idx = find(strcmp(val,stopsTable.stop_id));
                stopID = stopsTable.stop_code(idx);
                Routes(nRoutes).stops = [Routes(nRoutes).stops stopID];
                if ~ismember(stopID,[Stops.ID])
                    nStops = nStops + 1;
                    Stops(nStops).ID = stopID;
                    Stops(nStops).name = char(stopsTable.stop_name(idx));
                    Stops(nStops).x = stopsTable.stop_lon(idx);
                    Stops(nStops).y = stopsTable.stop_lat(idx);
                end
            end
            
            % build Links
            Routes(nRoutes).links = [];
            curStops = Routes(nRoutes).stops;
            % link shape coords
            idx = find([shapesTable.shape_id == finalShapeID]);
            shapeCoords = [shapesTable.shape_pt_lon(idx),shapesTable.shape_pt_lat(idx)];
            for j = 1:length(curStops) - 1
                oStop = curStops(j);
                dStop = curStops(j+1);
                
                idx = find([Links.oStop] == oStop & [Links.dStop] == dStop);
                if isempty(idx)
                    nLinks = nLinks + 1;
                    Links(nLinks).ID = nLinks;
                    Links(nLinks).oStop = oStop;
                    Links(nLinks).dStop = dStop;
                    geometry = extractGeometry(oStop,dStop,Stops,shapeCoords);
                    Links(nLinks).geometry = geometry;
                    
                    Routes(nRoutes).links = [Routes(nRoutes).links Links(nLinks).ID];
                else
                    Routes(nRoutes).links = [Routes(nRoutes).links Links(idx).ID];
                end
            end
            
        end
    catch
        disp(strcat('Problem happens to route:', char(routeID)));
    end
    
end

end % end function