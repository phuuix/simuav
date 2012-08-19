% Receive a subframe
function [out_bits] = rx_subframe(rx_signal, sim_options)

% Find symbol edge
rx_signal = rx_time_sync(rx_signal, sim_options);

% Estimate FFO
ffo = rx_estimate_ffo(rx_signal, sim_options);

% Correct with FFO + IFO + RFO

% Return to frequency domain

% Estimate IFO

% Estimate RFO

% Demodulate
