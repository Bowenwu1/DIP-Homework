function [ output_img ] = DFT(f)

[M, N] = size(f);

f = double(f);

output_img = getDFTMatrix(M) * f * getDFTMatrix(N);

end

