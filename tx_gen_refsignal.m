% Generate reference signals
function [out_refsig] = tx_gen_refsignal(in_subframe, in_ofdm_symbol)

global sim_consts;
global sim_store;

nsubc = sim_consts.NumSubc;
out_refsig = zeros(1, nsubc);

% only consider 72 subcarrier now
if nsubc ~= 72 
    return;
end

N = 63; 

if (in_ofdm_symbol == sim_consts.SyncSymbolIdx(1))
    u = 29;
    for n=0:30
        out_refsig(n+1+5) = exp(-1i*pi*u*n*(n+1)/N);
        out_refsig(n+32+5) = exp(-1i*pi*u*(n+32)*(n+33)/N);
    end
    sim_store.refsig(1, :) = out_refsig;
end

if (in_ofdm_symbol == sim_consts.SyncSymbolIdx(2))
    u = 34; % u=25 or 34, space=5
    for n=0:30
        pos = mod((n + in_subframe*5), 62);
        out_refsig(pos+1+5) = exp(-1i*pi*u*n*(n+1)/N);
        
        pos = mod((n + 31 + in_subframe*5), 62);
        out_refsig(pos+1+5) = exp(-1i*pi*u*(n+32)*(n+33)/N);
    end
    sim_store.refsig(2, :) = out_refsig;
end


