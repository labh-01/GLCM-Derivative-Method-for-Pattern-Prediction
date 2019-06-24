function pattern = derivative1(I)

I = imgaussfilt(I);
    I=rgb2gray(I);
    [r,c]=size(I);
    
    %diagonal og image
    diag = sqrt(r*r+c*c);
     R = diag/2;
    
    %taking cetner of image 
    x = ceil(r/2);  
    y = ceil(c/2);
    %R = 1000;
    
 %angle to traverse image clockwise with center at center of the image and middle row for theta=0    
theta = 0;
pattern = 'can not determined';
j=1;


while theta ~= 170
     
   theta1 = (theta*3.14)/180; 
   
   %center of image is starting point of line and (p,q) is end point of
   %line on image.
   x1 = R*sin(theta1); 
   y1 = R*cos(theta1);
   p = floor(x+x1);
   q = floor(y+y1);
   
   %deriv1 stores derivatives(difference array)
   deriv1 = findderivative(I,x,y,p,q,theta);
   deriv2 = unique(deriv1,'first');
   
   %max of derivative array is taken to take maximum change of pixel value
   %And this max change for all angles (from 0 degree to 170) degree are stored 
   max_of_diff_array(1,j) = max(deriv2);
   j=j+1;
%    if max_deriv < 30
%        pattern = check_pattern(theta)
%        break;
%    end
    theta = theta + 5;

end


[min_der,index_of_angle] = min(max_of_diff_array);
pattern = check_pattern(index_of_angle*5);
end


%using bresenham's line drawing algorithm to find all pixel position on line
%from point(x1,y1) to (x2,y2) 
%pixel positions are calculated to find derivative array(difference array)

function [deriva] = findderivative(I,x1,y1,x2,y2,theta1)
   [r,c] = size(I);
   dx = x2-x1;
   dy = abs(y2-y1);
   x =x1;
   y=y1;
   px = x;
   py = y;
   
   
   %slope = tan((abs(90-theta1))*3.14/180)
   i=1;
   deriva = zeros(size(1,c));
   if dx == 0
      while y<c
       deriva(1,i)=abs(I(x,y)-I(x,y+1));
            i=i+1;
            y=y+1;
      end
   elseif dy == 0
       while x<r
       deriva(1,i)=abs(I(x,y)-I(x+1,y));
            i=i+1;
            x=x+1;
      end
   
   else
       slope = floor(dy/dx);
   if slope<1
       i=1;
        pk = 2*dy - dx;
    % pk1 = pk + 2*dy - 2*dx*(yk1-yk);
   m=0;
    while x < x2 
        if (x>=1 && x<=r && y>=1 && y<=c) && (px>=1 && px<=r && py>=1 && py<=c)
            deriva(1,i)=abs(I(x,y)-I(px,py));
            i=i+1;
            m=m+1;
        end
        px=x;
        py=y;
       if pk >= 0
           if theta1 <= 90
             y = y+1;
           else
              y = y-1;
           end
       end
           x = x+1;
           pk = pk + 2*dy - 2*dx*(abs(y-py));
           
    end
   
   elseif slope > 1
       i=1;
       m=0;
       pk = 2*dx - dy;
    % pk1 = pk + 2*dx - 2*dy*(xk1-xk);
     while x < x2
         
       if (x>=1 && x<=r && y>=1 && y<=c) && (px>=1 && px<=r && py>=1 && py<=c)
            deriva(1,i)=abs(I(x,y)-I(px,py));
            i=i+1;
            m=m+1;
       end
        px=x;
        py=y;
       if pk >= 0
          x = x+1;
       end
       if theta1 <= 90
           y = y+1;
       else
           y=y-1;
       end
          pk = pk + 2*dx - 2*dy*(abs(x-px)); 
     end
   else
      
       m=0;
        pk = 2*dx - dy;
    % pk1 = pk + 2*dx - 2*dy*(xk1-xk);
     while x < x2 
        if (x>=1 && x<=r && y>=1 && y<=c) && (px>=1 && px<=r && py>=1 && py<=c)
            deriva(1,i)=abs(I(x,y)-I(px,py));
            i=i+1;
            m=m+1;
        end
        px=x;
        py=y;
        x = x+1;
        if theta1 <= 90
             y = y+1;
        else
           y=y-1;
        end
      end
   end
   end
end


%for different angles pattern is decided

function pattern = check_pattern(theta)
    if theta >= 0 && theta <= 20
        pattern = 'horizontal striped';
    elseif theta >= 25 && theta <= 75
        pattern = 'left diagonal striped';
    elseif theta >= 80 && theta <= 100
        pattern = 'vertical striped';
    elseif theta >= 105 && theta <= 170
        pattern = 'right diagonal striped';
    
    end
end