% Generate a OFDM symbol (IFFT + CP)
function [out_samps] = tx_gen_ofdm_symbol(in_ofdm_symbol, in_data)
    global sim_consts;
    
    nfft = sim_consts.NFFT;
    ncp = sim_consts.NCP(in_ofdm_symbol);
    nsubc = sim_consts.NumSubc;
    
    input_ifft = zeros(1, ncp+nfft);
    input_ifft(ncp+nfft/2-nsubc/2:ncp+nfft/2+nsubc/2) = in_data;
	out_samps = ifft(input_ifft);
	cp_samps = out_samps(nfft-ncp+1:nfft);
	out_samps = [cp_samps, out_samps];
end
