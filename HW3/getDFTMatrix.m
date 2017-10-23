function [output] = getDFTMatrix(size)
output = zeros(size, size);
for i = 1 : size
    for j = 1 : size
        output(i, j) = exp(-1i * 2 * pi * i * j / size);
    end
end

end

