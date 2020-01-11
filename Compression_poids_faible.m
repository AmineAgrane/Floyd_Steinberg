%PROJET
%Algorithme de Compression_poids_faible
%AGRANE Amine KHELFANE Lydia
clear all; 
close all;

%On lit l'image à compresser
Image=imread('lena.jpg');
[NL,NC]=size(Image);
subplot(1,2,1);
imshow(uint8(Image));
xlabel("Image avant la compression");

%On lit un pixel à la position [i,j]
%On convertit sa valeur décimal en valeur binaire
%On affecte au 4 derniers bits de sa valeur binaire la valeur 0
%On reconvertit la nouvelle valeur en décimal 
%On affecte la nouvelle valeur décimal au pixel [i,j]
for i=1:NL
    for j=1:NC
        tab=dec2bin(Image(i,j),8);
        tab(5:8)='0';
        x=bin2dec(tab);
        Image(i,j)=x;
    end 
end

%On affiche la nouvelle image obtenue
subplot(1,2,2);
imshow(uint8(Image));
xlabel("Image après la compression");
