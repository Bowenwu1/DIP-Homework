
for i = 1 : 17
    plotIndex = (i - 1) * 2 + 1;
    subplot(6, 12, plotIndex);
    imshow(result02{i});
    [temp, temp2] = preprocessForMnist(result02{i});
    result = model.predict(temp);
    title(result{1});
    subplot(6, 12, plotIndex + 1);
    imshow(temp2);
end