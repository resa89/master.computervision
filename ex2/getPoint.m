function position  = getPoint(hdt)
% Display an observation's Y-data and label for a data tip
% obj          Currently not used (empty)
% event_obj    Handle to event object

dcs=hdt.DataCursors;
position = get(dcs(1),'Position');   %Position of 1st cursor
end
