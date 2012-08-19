% Generate a subframe
function [tx_signals] = tx_gen_subframe(subframe)

global sim_consts;
global sim_store;

nSamples = sum(sim_consts.NCP+sim_consts.NFFT);
tx_signals = zeros(1, nSamples);

iSignal = 1;
for ofdmSymbol=0:sim_consts.NumOfdmSymbol-1
    if ofdmSymbol==sim_consts.SyncSymbolIdx(1) || ofdmSymbol==sim_consts.SyncSymbolIdx(2)
        tx_symbols = tx_gen_refsignal(subframe, ofdmSymbol);
    else
        % generate some random bits
        tx_bits = rand(1, sim_consts.NumSubc*2)>0.5;
        sim_store.tx_bits(subframe+1, ofdmSymbol+1, :) = tx_bits;
        tx_symbols = modulation_mapper(tx_bits, 'qpsk');
    end

    tx_signals(iSignal:iSignal+sim_consts.NCP(ofdmSymbol+1)+sim_consts.NFFT-1) = ...
        tx_gen_ofdm_symbols(ofdmSymbol, tx_symbols);
    
    iSignal = iSignal+sim_consts.NCP(ofdmSymbol+1)+sim_consts.NFFT;
end
