vehicle = imread('C:\Users\Devvrat Bani\Downloads\test1.jpg');
gray = rgb2gray(vehicle);

se = strel('disk', 5);
erode = imerode(gray, se);

X = edge(erode, 'sobel', 'horizontal');
Y = edge(erode, 'sobel', 'vertical');
A = X + Y;

kernel = [111; 111; 111]/9;
Acon = conv2(double(A), kernel, 'same');

fill = imfill(Acon, 'holes');
plate = fill & ~Acon;

filtered = bwareaopen(plate, 500);
labeled = bwlabel(filtered);
region = regionprops(labeled, 'BoundingBox');
bounding = region.BoundingBox;

number_plate = imcrop(vehicle, bounding);

grayplate = rgb2gray(number_plate);
binaryplate = imbinarize(grayplate);
dilatedplate = imdilate(binaryplate, strel('diamond', 1));

results = ocr(dilatedplate, 'CharacterSet', '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
text = results.Text;
disp(text);



