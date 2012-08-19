function sim_options = read_sim_options

global sim_options;

sim_options = struct('PacketLength', 100, ...
   'ConvCodeRate', 1/2, ...
   'InterleaveBits', 0, ...
   'Modulation', 'QPSK',...
   'UseTxDiv', 0, ...
   'UseRxDiv', 0, ...
   'FreqError', 0, ...
   'ChannelModel', 'AWGN', ...
   'ExpDecayTrms', 10, ...
   'SNR', 20,...
   'UseTxPA', 0, ...
   'UsePhaseNoise', 0, ...
   'PhaseNoisedBcLevel', 0, ...
   'PhaseNoiseCFreq', 0, ...   
   'PhaseNoiseFloor', 0, ...      
   'TimeSyncMode', 'replica', ... %replica or autocorrelation
   'FreqSyncMode', 'replica', ...
   'TxPowerSpectrum', 0, ...
   'ChannelEstimation', 0, ... 
   'NFrame', 1);
