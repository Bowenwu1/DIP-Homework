function [ output_img ] = dft2d(input_img, flag)
%dft2d
% When flag is true, do DFT
% When flag is false, do IDFT
if (flag)
    output_img = DFT(input_img);
else
    output_img = IDFT(input_img);
end

end

