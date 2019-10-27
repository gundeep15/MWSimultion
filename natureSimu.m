 w0 = 0.1;
mainMatrix =  zeros(1,1000); % all inactive initially
  
R0 = 10; %Decay Lenth = 5 seat units
threshold =0.22;
perm =20;

outputVideo = VideoWriter('shuttle_out.avi');
open(outputVideo)
waittime =5;


for time = 1:100 % time matrix  from 1 to 100 time units.
  n=1;  
%%
%pause(0.1)
   image(mainMatrix*255);
  % fi = sprintf('im%d.png',time); 
   saveas(gcf,'im1.png')
  % img = mat2gray(mainMatrix);
  % writeVideo(outputVideo,img)
    
   if exist('randIdcs','var')
      mainMatrix(randIdcs) =0; 
    end
       
    % if randindcs exist kill them 

    randIdcs = randperm(length(mainMatrix),perm);
    mainMatrix(randIdcs) =1;
    
    for i=1:length(mainMatrix)
        temp = (i-3*R0):(i+3*R0);
        temp = temp(temp>0);
        temp = temp(temp<length(mainMatrix));
        temp = temp(temp~=i);
        sumWeight =0;
        
        for j =1:length(temp)
            if(temp(j)>i)
                w(j) = exp((abs(temp(j)-i))/R0)* 2;
                if(mainMatrix(temp(j))==1)
                    sumWeight = sumWeight +w(j);
                end
            elseif(temp(j)<i)
                w(j) = exp((abs(temp(j)-i))/R0)*(2*w0);
                if(mainMatrix(temp(j))==1)
                    sumWeight = sumWeight +w(j);
                end
            end
            
            k(i) = 1/sum(w(:));
            finWeight(i) = (k(i))* sumWeight;
            if(finWeight(i)>threshold)
                mainMatrix(i) =1;
                Excited(time, n) = i;
                n=n+1;
                
                if (time>10)
                    StoodUP = Excited(time-7, :);
                    StoodUP = unique(StoodUP);
                    StoodUP = StoodUP(StoodUP>0);
                    mainMatrix(StoodUP) = 0;
                end
            end
        end
                
            
    end
end



