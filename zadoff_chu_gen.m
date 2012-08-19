
function [seqence] = zadoff_chu_gen(u, N)
seqence = zeros(N, 1);

for n=0:(N-1)
    seqence(n+1) = exp(-1i*pi*u*n*(n+1)/N);
end

