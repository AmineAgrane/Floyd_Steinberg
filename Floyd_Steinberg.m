%PROJET
% Le tramage de l''image par l''algorithme de Floyd-Steinberg
%Algorithme de FLoyd Steinberg

clear all;
close all;
 

%Image original

A=imread('lena.bmp');
B=A;
image_originale=A;

%Première figure

figure;
subplot(2,3,1);
imshow(uint8(A));
title('Image originale');

%%Histogramme de l'image original 

[NL,NC]=size(A);
   H = zeros(1,256);
    for i=1:NL
        for j=1:NC         
           H(A(i,j)+1)= H(A(i,j)+1)+1;
       end
    end

    subplot(2,3,4);
    plot(0:255,H);
    
%Image quantifiée

for i=2:NL-1
    for j=2:NC-1
 
        ancien_pixel= B(i,j);
        
        if (ancien_pixel>=0 & ancien_pixel<=63)
            nouveau_pixel=0;          
        
        elseif(ancien_pixel>=64 & ancien_pixel<=127)
            nouveau_pixel=64;
    
        
        elseif(ancien_pixel>=128 & ancien_pixel<=191)
            nouveau_pixel=128;
        
        
        elseif (ancien_pixel>=191 & ancien_pixel<=255)
            nouveau_pixel=255;
        end  
        
         B(i,j)=nouveau_pixel;
    end 
end

subplot(2,3,2);
imshow(uint8(B));
title('Image après Quantification');

%histogramme de l'image quantifiée

[NL,NC]=size(B);
    F = zeros(1,256);
    for i=1:NL
        for j=1:NC         
           F(B(i,j)+1)= F(B(i,j)+1)+1;
        end
    end
    

    subplot(2,3,5);
    plot(0:255,F);


%Application de l'algorithme de Floyd-Steinberg
for i=2:NL-1
    for j=2:NC-1
 
        ancien_pixel= A(i,j);
        
        if (ancien_pixel>=0 & ancien_pixel<=63)
            nouveau_pixel=0;                  
        elseif(ancien_pixel>=64 & ancien_pixel<=127)
            nouveau_pixel=64;
        elseif(ancien_pixel>=128 & ancien_pixel<=191)
            nouveau_pixel=128;
        elseif (ancien_pixel>=191 & ancien_pixel<=255)
            nouveau_pixel=255;
        end  
        
         A(i,j)=nouveau_pixel;
         erreur_quantification=(ancien_pixel- nouveau_pixel);
         A(i+1,j)=A(i+1,j)+(7/16)* (erreur_quantification);
         A(i-1,j+1)=A(i-1,j+1)+ (7/16)*( erreur_quantification);
         A(i,j+1)=A(i,j+1)+ (7/16)*( erreur_quantification);
         A(i+1,j+1)=A(i+1,j+1)+ (7/16)*( erreur_quantification); 
    end 
end

%Image après l'application de l'algorithme de Floyd-Steinberg

image_finale=A;
subplot(2,3,3);
imshow(uint8(A));
title('Image après application de l''algorithme de Floyd-Steinberg');

%Histogramme après application de l'algorithme de FLoyd-Steinberg

[NL,NC]=size(A);
    H = zeros(1,256);
    for i=1:NL
        for j=1:NC         
           H(A(i,j)+1)= H(A(i,j)+1)+1;
        end
    end
    
   subplot(2,3,6);
   plot(0:255,H);
   
 %La courbe tonale à quatres paliers
 
 k=4; //4 palier
 K=[0:255];     //creation des vecteure de la courbe tonale
 
 
 g=abs(256/k);
 l=0;
 for i=1:256
      while (l<=k)
          if(i<=((l+1)*g))
              K(i)=l*g;
              l=l+k+1;
          else
              l=l+1;
          end
      end
    l=0;
 end
    
%Deuxième figure 

figure;
plot(K);
title('La courbe tonale');
               

%Troisième figure

figure;
subplot(1,2,1);
imshow(uint8(image_originale));
title('Image avant application de l''algorithme de Floyd-Steinberg');

subplot(1,2,2);
imshow(uint8(image_finale));
title('Image aprèss application de l''algorithme de Floyd-Steinberg');
