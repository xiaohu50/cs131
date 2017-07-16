% 5 SVD for Image Compression
img = double(rgb2gray(imread('flower.bmp')));
imshow(uint8(img));
title('img'); 

% a
[U, S, V]=svd(img);
singulars = diag(S);
disp(singulars(1:10));
figure;
plot(1:size(singulars), singulars);
title('singular')

% b
rimg = U*S*V';
figure;
imshow(uint8(rimg));
title('rimg'); 
for k=[10, 50, 100]
    U2 = U(:, 1:k);
    S2 = S(1:k, 1:k);
    V2 = V(:, 1:k);
    newimg = U2 * S2 * V2';
    figure;
    imshow(uint8(newimg));
    title(['k=', num2str(k)]);
end

% c
% original: 300*300=90,000
% after svd with k=200: 300*200 + 200 + 300*200=120,200
% will not save space

% d
% suppose 
% U = E | F
% S = A | 0
%    ------
%     0 | B
% V'= X
%    ---
%     Y
% then img = EAX + FBY, here EAX is the compressed image, FBY is the error.
% Cause U and V are always rotaLon matrices, every element in matrix U/V is
% less than 1, so e(i, j) is a row in FB multiply a column in Y.
% Each row in FB only have first r-k non-zero values, and each value is
% small than the original singular in S, 
% e(i, j) <= p * sum(oi), p=r-k

% e 
% just enumerate k from 1 to r is computable

%------------------------------------------------------------
% 6  SVD application - Matrix Norm

% a
% ||A||2 = sqrt(x'VS'U' *  USV'x)
%        = sqrt(w' * S' * S * w), where S is a diagonal matrix
% iff w'=(1,0,0,0...) will maximize ||A||2
% so ||A||2 will be omax

% b
% A'A = V S' U' U S V'
%     = V S' S V'
% trace(A'A) = trace(V' A'A V)
%            = trace(S'S)
%            = o1^2 + o2^2 + o3^2 + o4^2
