function [output_img] = noise_generator(origin_img, mu, sigma, pepper, salt)
% mu : mean
% sigma : standard deviation
% pepper : prop
[m, n] = size(origin_img);
output_img = zeros(m, n);
pepperAndSalt = pepper + salt;
% make pepper + salt = 1
pepper = pepper / pepperAndSalt;
% salt   = salt / pepperAndSalt;
for i = 1 : m
    for j = 1 : n
        % Gaussian noise
        u1 = rand();
        u2 = rand();
        z = ((-2 * log(u1)) ^ 0.5) * sin(2 * pi * u2);
        output_img(i, j) = origin_img(i, j) + (z * sigma + mu);
        
        % pepper and salt noise happen
        if rand() <= pepperAndSalt
            % pepper noise
            if rand() < pepper
                output_img(i, j) = 0;
            else
                output_img(i, j) = 255;
            end
        end
    end
end
output_img = uint8(output_img);
end