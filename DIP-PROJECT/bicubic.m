function [ output_img ] = bicubic(input_img, height, width)
    function [output] = getPixel(x, y)
        if (x > 0 && x <= origin_height && y > 0 && y <= origin_width)
            output = input_img(x, y);
        else
            % outbound condition
            output = 0;
        end
    end

    function [output] = W(x)
        x = abs(x);
        if (x >= 0 && x <= 1)
            output = 1.5 * x^3 - 2.5 * x^2 + 1;
        elseif (x > 1 && x <= 2)
            output = -0.5 * x ^ 3 + 2.5 * x^2 - 4 * x + 2;
        else
            output = 0;
        end
    end

% Zooming 
[origin_height, origin_width] = size(input_img);
output_img = zeros(height, width);
h_radio = origin_height / height;
w_radio = origin_width / width;

for m = 1 : height
    for n = 1 : width
        % zuo shang orientation
        target_m = (m - 1) * h_radio + 1;
        target_n = (n - 1) * w_radio + 1;
        target_m_floor = floor(target_m);
        target_n_floor = floor(target_n);
        % Directly copy the formula
        for x = target_m_floor - 2 : target_m_floor + 2
            for y = target_n_floor - 2 : target_n_floor + 2
                output_img(m, n) = output_img(m, n) + getPixel(x, y) * W(x - target_m) * W(y - target_n);
            end
        end
    end
end

output_img = uint8(output_img);

end

