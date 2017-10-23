function [ output_img ] = IDFT(f)

[M, N] = size(f);

f = conj(f);

output_img = getDFTMatrix(M) * f * getDFTMatrix(N);

output_img = conj(output_img) / (M * N);

end

