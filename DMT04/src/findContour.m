function [output] = findContour( input)

input_gray = rgb2gray(input);
[input_m, input_n] = size(input_gray);

% Clear Noisy
input_gray = filter2(fspecial('average',5),input_gray);
% corrupt
input_bw = edge(input_gray);
input_bw_uint8 = zeros(input_m, input_n);
input_bw_uint8(input_bw == 1) = 0;
input_bw_uint8(input_bw == 0) = 255;
input_bw_min = min_median_max_filter2d(input_bw_uint8, 3, 3, @min);
input_bw_min = min_median_max_filter2d(input_bw_min, 3, 3, @max);

% figure, imshow(input_bw_min);
input_bw_edge = edge(input_bw_min);

% 
threshold_padding = 10;

% Make segements
segement = bwlabel(input_bw_edge);
first_segement_num = 1;
segement_num = max(segement(:));


% Pick Up result images
pieceIndex = 0;
output = {};
ROISet = {};

for m = 1 : input_m
    for n = 1 : input_n
        if (segement(m, n) ~= 0)
            % find one segment
            now_segement = segement(m, n);
            [row, col] = find(segement == now_segement);
            row_min = min(row(:));
            row_max = max(row(:));
            col_min = min(col(:));
            col_max = max(col(:));
            if row_min < input_m - threshold_padding && row_min > threshold_padding...
            && col_min < input_n - threshold_padding && col_min > threshold_padding...
            && (abs(row_max - row_min) > 5 || abs(col_max - col_min) > 5)
                segement(row_min : row_max, col_min : col_max) = 0;
                pieceIndex = pieceIndex + 1;
                ROISet{pieceIndex} = [col_min row_min col_max - col_min row_max - row_min];
            end
        end
    end
end
ROISet = sortROI(ROISet);
[~, pieceIndex] = size(ROISet);
for i = 1 : pieceIndex
    output{i} = imcrop(input, ROISet{i});
end

    function [output] = sortROI(set)
        [~, setSize] = size(set);
        for outerIndex = 1 : setSize
            for interIndex = outerIndex + 1 : setSize
                if comp(set{outerIndex}, set{interIndex}) == 0
                    [set{outerIndex}, set{interIndex}] = swap(set{outerIndex}, set{interIndex});
                end
            end
        end
        output = set;
        function [result] = comp(s1, s2)
            x1 = s1(1);
            y1 = s1(2);
            x2 = s2(1);
            y2 = s2(2);
            if abs(y1 - y2) < 30
                if x1 < x2
                    result = 1;
                else
                    result = 0;
                end
            elseif y1 < y2
                result = 1;
            else
                result = 0;
            end
        end
        function [output1, output2] = swap(input1, input2)
            output2 = input1;
            output1 = input2;
        end
        
    end
end

