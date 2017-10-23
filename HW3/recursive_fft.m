function [ output ] = recursive_fft(input, M, v, N)
% called by postive_fft and work recursively

% end condition
if (1 == M)
    output = zeros(M, 1);
    output(1) = input(1, 1) * exp(-1i * 2 * pi * 1 * 1);
    return;
end
% recursive condition
output = zeros(M, 1);
K = M / 2;

even_input = zeros(N, K);
for x = 1 : K
    even_input(:, x) = input(:, 2 * (x - 1) + 1);
end

odd_input = zeros(N, K);
for x = 1 : K
    odd_input(:, x) = input(:, 2 * x);
end
F_even = recursive_fft(even_input, K, v, N) / K;
F_odd  = recursive_fft(odd_input, K, v, N) / K;

for u = 1 : K
    F_odd(u) = F_odd(u) * exp(-1i * 2 * pi * u / M);
end

for u = 1 : K
    output(u) = (F_even(u) + F_odd(u)) / 2;
end

for u = K + 1 : M
    output(u) = (F_even(u - K) - F_odd(u - K)) / 2;
end

end

