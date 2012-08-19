% Generate a OFDM symbol: include CP 
function [tx_signals] = tx_gen_ofdm_symbols(in_ofdm_symbol, in_mod_symbol)

global sim_consts;

nfft = sim_consts.NFFT;
nsubc = sim_consts.NumSubc;
ncp = sim_consts.NCP(in_ofdm_symbol+1);

tx_symbols = zeros(1, nfft);

tx_symbols((nfft-nsubc)/2+1:(nfft+nsubc)/2) = in_mod_symbol;

tx_signals = ifft(tx_symbols);

tx_signals = [tx_signals(nfft-ncp+1:nfft), tx_signals];

