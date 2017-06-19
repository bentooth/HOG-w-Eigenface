function [startPosC, winInfoC, flag] = VerifyOverlapping(startPosA, winInfoA, startPosB, winInfoB)
% Qi: Change the function to the following:
% function [startPosC, winInfoC, flag] = VerifyOverlapping(startPosA, winInfoA, startPosB, winInfoB)
%flag is marked as 1 if overlapping and 0 otherwise.
%C is the newly merged window.


% image = imread('im1.jpg');

% Replace the following four statements as follows:
   Axy = startPosA; 
   ALxy = [Axy(1)+winInfoA(1) Axy(2)+winInfoA(2)];
    
   Bxy = startPosB; 
   BLxy = [Bxy(1)+winInfoB(1) Bxy(2)+winInfoB(2)];

   
    if Bxy(1) >= Axy(1) && Bxy(2) >= Axy(2) && BLxy(1) >= ALxy(1) && Bxy(2) <= ALxy(2) && abs(Bxy(1)-Axy(1)) <= winInfoA(2) && abs(BLxy(2) - ALxy(2)) <= winInfoA(1)
 
        % Add by Qi:  -- add these two lines to all the if conditions
        startPosC = [Axy(2) Axy(1)];
        winInfoC = [winInfoA(1)+(abs(ALxy(2)-BLxy(2)))  winInfoA(2)+(BLxy(1)-ALxy(1))] ;

        flag = 1;
        
        
    else if Bxy(1) >= Axy(1) && Bxy(2) <= Axy(2) && BLxy(1) >= ALxy(1) && BLxy(2) <= ALxy(2) && abs(Bxy(1)-Axy(1)) <= winInfoA(2) && abs(BLxy(2) - ALxy(2)) <= winInfoA(1)

        startPosC = [(Axy(2)-(Axy(2)-Bxy(2))) Axy(1)];
        winInfoC =  [(winInfoA(1)+(ALxy(2)- BLxy(2))) (winInfoA(2)+(BLxy(1)-ALxy(1)))] ;

        flag = 1;
        
        
   else if Bxy(1) <= Axy(1) && Bxy(2) <= Axy(2) && BLxy(1) <= ALxy(1) && BLxy(2) <= ALxy(2) && abs(Bxy(1)-Axy(1)) <= winInfoA(2) && abs(BLxy(2) - ALxy(2)) <= winInfoA(1)

        startPosC = [Bxy(2) Bxy(1)];
        winInfoC =  [(winInfoA(1)+(ALxy(2) - BLxy(2))) (winInfoA(2)+(ALxy(1)-BLxy(1)))] ;

        flag = 1;

   else if Bxy(1) <= Axy(1) && Bxy(2) >= Axy(2) && BLxy(1) <= ALxy(1) && BLxy(2) >= ALxy(2)&& abs(Bxy(1)-Axy(1)) <= winInfoA(2) && abs(BLxy(2) - ALxy(2)) <= winInfoA(1)   
       
        startPosC = [Axy(2) Bxy(1)];
        winInfoC =  [(winInfoA(1)+(BLxy(2) - ALxy(2))) (winInfoA(2)+(ALxy(1)-BLxy(1)))] ;

        flag = 1;
        
        
        
   else if Bxy(1) >= Axy(1) && Axy(2) <= Bxy(2) && BLxy(1) >= ALxy(1) && BLxy(2) <= ALxy(2)&& abs(Bxy(1)-Axy(1)) <= winInfoA(2) && abs(BLxy(2) - ALxy(2)) <= winInfoA(1)

        
        startPosC = [(Bxy(1)-(abs(BLxy(1)-ALxy(1)-1))) Bxy(2)-1];
        winInfoC =  [(winInfoA(1)+( ALxy(2) - BLxy(2) )) (winInfoA(2)+(Bxy(1) - Axy(1)))] ;
        flag = 1; 
        
        
       else
         startPosC = 0;
         winInfoC =  0;
         flag = 0;
       end
    end
        end
    end
      
end

    
 


        
    
    
