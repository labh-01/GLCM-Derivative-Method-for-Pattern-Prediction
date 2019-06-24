 clear
 clc
global theImage;
global img_cropped;
hs = 0;
vs = 0;
lds = 0;
rds = 0;
ch = 0;
ir = 0;
for i = 1:45
    filepath = 'C:\Users\Prateek\Desktop\mini_project\horizontal\';
    file = int2str(i);
    filen = strcat(filepath,file);
    filename = strcat(filen,'.jpg');
    if exist(filename, 'file')
        theImage = imread(filename);
     %   imshow(theImage);
    else
        message = sprintf('Image file not found:\n%s', filename);
    end
    row = size(theImage,1)
    col = size(theImage,2)
    k=1;
    ra = 150;
    for j=1:5
        r= randi([1,row-ra]);
        c= randi([1,col-ra]);
        redChannel = theImage(r:(r+ra),c:(c+ra), 1);
        greenChannel = theImage(r:(r+ra),c:(c+ra), 2);
        blueChannel = theImage(r:(r+ra), c:(c+ra), 3);
        img_cropped = cat(3, redChannel, greenChannel, blueChannel);
        patternArr{j} = glcm_derivative1(img_cropped);
       
        imshow(img_cropped);
    end
    unique_pattern = unique(patternArr);
    n = zeros(length(unique_pattern), 1);
    for iy = 1:length(unique_pattern)
      n(iy) = length(find(strcmp(unique_pattern{iy}, patternArr)));
    end
    [~, itemp] = max(n);
    pattern = unique_pattern{itemp};
    if strcmp(pattern,'horizontal stripped') == 1
        hs = hs + 1;
    else
        if strcmp(pattern,'vertical stripped') == 1
            vs = vs+1;
        else
            if strcmp(pattern,'left diagonal stripped') == 1
                lds = lds + 1;
            else
                if strcmp(pattern,'right diagonal stripped') == 1
                    rds = rds + 1;
                else
                    if strcmp(pattern,'chequered') == 1
                        ch = ch+1;
                    else
                        ir = ir + 1;
                    end
                end
            end
        end
    end
end
display(hs);
display(vs);
display(lds);
display(rds);
display(ch);
display(ir);
display(hs/(i)*100);