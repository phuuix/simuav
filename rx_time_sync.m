% Find the edge of symbol
function [offset] = rx_time_sync(rx_signal, sim_options)
global sim_consts;
global sim_store;

if strfind(sim_options.TimeSyncMode, 'replica')
    % replica
    
    % generate local pss
    pss_timedomain = sim_store.refsig(1, 5:5+63);
    pss_freqdomain = ifft(pss_timedomain);
    pss_freqdomain = conj(pss_freqdomain);
    
    % decimate by 2048/64=32
    index = 1;
    rx_sig_decimate = zeros(1, length(rx_signal)/32);
    for n=1:32:length(rx_signal)
        rx_sig_decimate(index) = rx_signal(n);
        index = index + 1;
    end
    
    % cross correlation 
    M = 1;
    N = 64;
    search_win = length(rx_sig_decimate)-N;
    sum_J = zeros(1, search_win);
    for d=1:search_win
        for m=1:M
            for n=1:N/M
                sum_J(d) = sum_J(d)+abs(pss_freqdomain(n+(m-1)*N/M).*rx_sig_decimate(n+(m-1)*N/M+d));
            end
        end
    end
    
     % detect max
    offset = 1;
    max_J = 0;
    for d=1:search_win
        if sum_J(d) > max_J
            max_J = sum_J(d);
            offset = d;
        end
    end
    
    disp(offset);
end

if strfind(sim_options.TimeSyncMode, 'autocorrelation')
    % autocorrelation
    seach_win = 2048;
    ncp = sim_consts.NCP;
    nfft = sim_consts.NFFT;
    sum_P = zeros(1, seach_win);
    sum_E = zeros(1, seach_win);
    
    for d=1:seach_win
        % 10 symbol (Q=10)
        for iSymbol=0:9
            for n=1:ncp
                sum_P(d) = sum_P(d) + ...
                    rx_signal(d+n+iSymbol*nfft).*conj(rx_signal(d+n+iSymbol*nfft+nfft));
                sum_E(d) = sum_E(d) + ...
                    rx_signal(d+n+iSymbol*nfft).*conj(rx_signal(d+n+iSymbol*nfft)) + ...
                    rx_signal(d+n+iSymbol*nfft+nfft).*conj(rx_signal(d+n+iSymbol*nfft+nfft));
            end
        end
    end
    
    % detect max
    offset = 1;
    max_P_E = 0;
    for d=1:search_win
        if abs(sum_P(d))/abs(sum_E(d)) > max_P_E
            max_P_E = abs(sum_P(d))/abs(sum_E(d));
            offset = d;
        end
    end
    
    disp(offset);
end

   