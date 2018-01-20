function [ output ] = sortCordination( input )

[n, ~] = size(input);
for i = 1 : n
    for j = i + 1 : n
        x_i = input(i, 1);
        x_j = input(j, 1);
        y_i = input(i, 2);
        y_j = input(j, 2);
        if (abs(x_i - x_j) > 200)
            % compare x
            if (x_j < x_i)
                % swap
                input(i, 1) = x_j;
                input(i, 2) = y_j;
                input(j, 1) = x_i;
                input(j, 2) = y_i;
            end
        else
            % compare y
            if (y_j < y_i)
                % swap
                input(i, 1) = x_j;
                input(i, 2) = y_j;
                input(j, 1) = x_i;
                input(j, 2) = y_i;
            end
        end
    end
end
output = input;

end

