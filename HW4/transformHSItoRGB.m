function [ output ] = transformHSItoRGB( img )
[m ,n, p] = size(img);
output = zeros(m, n, p);

for i = 1 : m
    for j = 1 : n
        H = img(i, j, 1);
        S = img(i, j, 2);
        I = img(i, j, 3);
        if H < 2*pi / 3
            B = I * (1 - S);
            R = I * (1 + (S*cos(H)/cos(pi/3-H)));
            G = 3 * I - (R + B);
        elseif H < 4*pi / 3
            H = H - 2*pi / 3;
            R = I * (1 - S);
            G = I * (1 + (S*cos(H)/cos(pi/3-H)));
            B = 3 * I - (R + G);
        else
            H = H - 4*pi / 3;
            G = I * (1 - S);
            B = I * (1 + (S*cos(H)/cos(pi/3-H)));
            R = 3 * I - (G + B);
        end
        output(i, j, 1) = R;
        output(i, j, 2) = G;
        output(i, j, 3) = B;
    end
end
output = uint8(output);
end

