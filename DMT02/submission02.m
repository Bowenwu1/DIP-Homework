% Created by BowenWu In 2017/12/07
% Read the Image
input = imread('input.jpg');
input_gray = rgb2gray(input);
[input_m, input_n] = size(input_gray);

% corrupt
input_bw_min = min_median_max_filter2d(input_bw, 5, 5, @min);
input_bw_edge = edge(input_bw_min);

% 
threshold_padding = 10;

% Make segements
segement = bwlabel(input_bw_edge);
first_segement_num = min(segement(:));
segement_num = range(segement(:));

% Draw the result contours
figure, imshow(input), hold on
for now_segement = first_segement_num : segement_num
    [row, col] = find(segement == now_segement);
    row_min = min(row(:));
    row_max = max(row(:));
    col_min = min(col(:));
    col_max = max(col(:));

    if row_min < input_m - threshold_padding && row_min > threshold_padding...
            && col_min < input_n - threshold_padding && col_min > threshold_padding
        rectangle('Position', [col_min row_min col_max - col_min row_max - row_min],...
             'EdgeColor', 'green', 'LineWidth', 1);
    end

end
hold off

% Pick Up result images
piece = 0;
for now_segement = first_segement_num : segement_num
    [row, col] = find(segement == now_segement);
    row_min = min(row(:));
    row_max = max(row(:));
    col_min = min(col(:));
    col_max = max(col(:));
    if row_min < input_m - threshold_padding && row_min > threshold_padding...
            && col_min < input_n - threshold_padding && col_min > threshold_padding
        result_img = imcrop(input, [col_min row_min col_max - col_min row_max - row_min]);
        figure, imshow(result_img);
        imwrite(result_img, strcat('DMT02/result/result-', num2str(piece), '.jpg'));
        piece = piece + 1;
    end
end