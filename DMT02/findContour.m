function [] = findContour( input_img_name, output_path)
% Read the Image
input = imread(input_img_name);
input_gray = rgb2gray(input);
[input_m, input_n] = size(input_gray);

% Clear Noisy
input_gray = filter2(fspecial('average',3),input_gray);
% corrupt
input_bw = edge(input_gray);
input_bw_uint8 = zeros(input_m, input_n);
input_bw_uint8(input_bw == 1) = 0;
input_bw_uint8(input_bw == 0) = 255;
input_bw_min = min_median_max_filter2d(input_bw_uint8, 5, 5, @min);

% figure, imshow(input_bw_min);
input_bw_edge = edge(input_bw_min);

% 
threshold_padding = 10;

% Make segements
segement = bwlabel(input_bw_edge);
first_segement_num = 1;
segement_num = max(segement(:));

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
             'EdgeColor', 'green', 'LineWidth', 3);
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
        imwrite(result_img, strcat(output_path, num2str(piece), '.jpg'));
        piece = piece + 1;
    end
end

end

