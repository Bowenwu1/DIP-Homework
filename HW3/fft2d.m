function [ output_img ] = fft2d(input_img, flag)
% Fast Fourier Transformation Implementaion
% This algorithm is slower than dft2d
% flag: true for DFT, false for Inverse DFT

% save the origin input_img size
[origin_width, origin_height] = size(input_img);

% scale the input_img into proper size
% find the proper size
M = 1;
N = 1;
while true
    if (origin_width >= M && origin_width <= 2 * M)
        if (2 * M - origin_width < origin_width - M)
            M = 2 * M;
        end
        break;
    else
        M = 2 * M;
    end
end

while true
    if (origin_height >= N && origin_height <= 2 * N)
        if (2 * N - origin_height < origin_height - N)
            N = 2 * N;
        end
        break;
    else
        N = 2 * N;
    end
end
% scale
input_img = imresize(input_img, [M N]);
input_img = double(input_img);

% Calculate F(x, v)
% G is an inter matrix
G = zeros(M, N);

for v = 1 : N
    G(:, v) = recursive_fft(input_img, N, v, M);
end

F = zeros(M, N);
for v = 1 : N
    F(v, :) = recursive_fft(G, M, v, N);
end
output_img = F;
end

