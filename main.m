% main entry
clear;
clc;

global sim_options;

% Set simulation constants
set_sim_consts();

% Read simulation options
read_sim_options();

% Generate channel impulse response
cir = get_channel_ir(sim_options);
        
% Begin simulation
for nFrame=1:sim_options.NFrame
    for nSubFrame=0:9
        % Generate a subframe
        tx_signals = tx_gen_subframe(nSubFrame);
        
        % Channel model
        rx_signals = channel(tx_signals, cir, sim_options);
        
        % Receiver 
        rx_subframe(rx_signals, sim_options);
    end
end


