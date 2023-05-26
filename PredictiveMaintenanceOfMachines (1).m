% Prompt user for machine type
machine_type = input('Enter machine type: ','s');

% Prompt user for machine usage data
usage = input('Enter machine usage data as a vector within[] separated by comma or space: e.g 100 150 200 180 120');

% Prompt user for maintenance history data
history = input('Enter maintenance history data as a vector within[] separated by comma or space: e.g 50, 100, 80, 120, 90: ');

% Define maintenance thresholds (in hours)
pm_threshold = 500;
plm_threshold = 800;
cm_threshold = 1000;

% Calculate total usage time
total_usage = sum(usage);

% Calculate average usage per day (assuming 8-hour workdays)
avg_usage = sum(usage) / (length(usage) * 8);

% Calculate total maintenance time
total_maintenance = sum(history);

% Calculate average time between maintenance events
if length(history) > 1
    avg_maintenance = (history(end) - history(1)) / (length(history) - 1);
else
    avg_maintenance = Inf;
end

% Determine type of maintenance needed
if total_usage >= cm_threshold || avg_usage >= cm_threshold/8 || total_maintenance >= cm_threshold || avg_maintenance <= cm_threshold
    maintenance_type = 'Corrective Maintenance';
    maintenance_date = datetime('today') + caldays(30); % Maintenance needed in 30 days for corrective maintenance
elseif total_usage >= plm_threshold || avg_usage >= plm_threshold/8 || total_maintenance >= plm_threshold || avg_maintenance <= plm_threshold
    maintenance_type = 'Planned Maintenance';
    maintenance_date = datetime('today') + caldays(60); % Maintenance needed in 60 days for planned maintenance
elseif total_usage >= pm_threshold || avg_usage >= pm_threshold/8 || total_maintenance >= pm_threshold || avg_maintenance <= pm_threshold
    maintenance_type = 'Preventive Maintenance';
    maintenance_date = datetime('today') + caldays(90); % Maintenance needed in 90 days for preventive maintenance
else
    maintenance_type = 'No Maintenance Needed';
    maintenance_date = 'N/A';
end

% Display maintenance type and date
disp(['Maintenance type: ' maintenance_type]);
disp(['Maintenance needed on: ' char(maintenance_date)]);

% Prompt user to clear variables
prompt = input('Clear variables? (Y/N)', 's');
if strcmpi(prompt, 'Y')
    clear machine_type usage history pm_threshold plm_threshold cm_threshold total_usage avg_usage total_maintenance avg_maintenance prompt
end
