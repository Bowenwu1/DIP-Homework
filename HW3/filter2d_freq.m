function [ output_img ] = filter2d_freq( input_img, filter )

% Make sure the sum of elements in filter is 1
if (sum(sum(filter)) ~= 0)
    filter = filter / sum(sum(filter));
end

% Padding
[A, B] = size(input_img);
[C, D] = size(filter);

P = A + C - 1;
Q = B + D - 1;

f = zeros(P, Q);
h = zeros(P, Q);

for i = 1 : A
    for j = 1 : B
        f(i, j) = input_img(i, j);
    end
end

for i = 1 : C
    for j = 1 : D
        h(i, j) = filter(i, j);
    end
end

% Fourier Transform
F = dft2d(f, true);
H = dft2d(h, true);

% F(x, y)*H(x, y)
G = F .* H;

% Inverse Fourier Transform
g = dft2d(G, false);
% un-centerlized

output_img = uint8(g);
end

