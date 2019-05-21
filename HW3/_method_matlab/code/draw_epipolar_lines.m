% Draw Epipolar Lines Stencil Code
% CS 4476 / 6476: Computer Vision, Georgia Tech
% Written by Henry Hu

% Draw the epipolar lines given the fundamental matrix, left right images
% and left right datapoints

% You do not need to modify anything in this function, although you can if
% you want to.

function [] = draw_epipolar_lines( F0_matrix, F1_matrix, ImgLeft, ImgRight, PtsLeft, PtsRight,V,V1,U,U1)
    Pul=[1 1 1];
    Pbl=[1 size(ImgLeft,1) 1];
    Pur=[size(ImgLeft,2) 1 1];
    Pbr=[size(ImgLeft,2) size(ImgLeft,1) 1];

    lL = cross(Pul,Pbl);
    lR = cross(Pur,Pbr);
    figure
    imshow(ImgRight)
    for i = 1:size(PtsLeft,1)
%     for i = 1:1
        e = F0_matrix*[PtsLeft(i,:) 1]';
        PL = cross(e,lL);
        PR = cross(e,lR);
        x = [PL(1)/PL(3) PR(1)/PR(3)];
        y = [PL(2)/PL(3) PR(2)/PR(3)];
        line(x,y,'Color','r','LineWidth',1)
%         disp('epipolar line for F0 in image2 (line(x,y) function in Matlab)')
%         fprintf('vector x:\n%f\n',x(:,1))
%         fprintf('%f\n',x(:,2))
%         fprintf('vector y:\n%f\n',y(:,1))
%         fprintf('%f\n\n',y(:,2))
        
        e2 = F1_matrix*[PtsLeft(i,:) 1]';
        PL2 = cross(e2,lL);
        PR2 = cross(e2,lR);
        x2 = [PL2(1)/PL2(3) PR2(1)/PR2(3)];
        y2 = [PL2(2)/PL2(3) PR2(2)/PR2(3)];
        line(x2,y2,'Color','b','LineWidth',1) 
%         disp('epipolar line for F1 in image2 (line(x,y) function in Matlab)')
%         fprintf('vector x:\n%f\n',x2(:,1))
%         fprintf('%f\n',x2(:,2))
%         fprintf('vector y:\n%f\n',y2(:,1))
%         fprintf('%f\n\n',y2(:,2))
    end
    hold on
%     plot(PtsRight(1,1),PtsRight(1,2),'go','MarkerFaceColor','m','MarkerSize',6)
%     plot(PtsRight(6,1),PtsRight(6,2),'go','MarkerFaceColor','c','MarkerSize',6)
    plot(U(1,:),U(2,:),'go','MarkerFaceColor','c','MarkerSize',10)
    plot(U1(1,:),U1(2,:),'go','MarkerFaceColor','m','MarkerSize',10)
    hold off
    figure
    imshow(ImgLeft)
    for i = 1:size(PtsRight,1)
%     for i = 6:6
        e = F0_matrix'*[PtsRight(i,:) 1]';
        PL = cross(e,lL);
        PR = cross(e,lR);
        x = [PL(1)/PL(3) PR(1)/PR(3)];
        y = [PL(2)/PL(3) PR(2)/PR(3)];
        line(x,y,'Color','r','LineWidth',1)
%         disp('epipolar line for F0 in image1 (line(x,y) function in Matlab)')
%         fprintf('vector x:\n%f\n',x(:,1))
%         fprintf('%f\n',x(:,2))
%         fprintf('vector y:\n%f\n',y(:,1))
%         fprintf('%f\n\n',y(:,2))
        
        e2 = F1_matrix'*[PtsRight(i,:) 1]';
        PL2 = cross(e2,lL);
        PR2 = cross(e2,lR);
        x2 = [PL2(1)/PL2(3) PR2(1)/PR2(3)];
        y2 = [PL2(2)/PL2(3) PR2(2)/PR2(3)];
        line(x2,y2,'Color','b','LineWidth',1)
%         disp('epipolar line for F1 in image1 (line(x,y) function in Matlab)')
%         fprintf('vector x:\n%f\n',x2(:,1))
%         fprintf('%f\n',x2(:,2))
%         fprintf('vector y:\n%f\n',y2(:,1))
%         fprintf('%f\n\n',y2(:,2))
    end
    hold on
%     plot(PtsLeft(6,1),PtsLeft(6,2),'go','MarkerFaceColor','c','MarkerSize',6)
%     plot(PtsLeft(1,1),PtsLeft(1,2),'go','MarkerFaceColor','m','MarkerSize',6)
    plot(V(1,:),V(2,:),'go','MarkerFaceColor','c','MarkerSize',10)
    plot(V1(1,:),V1(2,:),'go','MarkerFaceColor','m','MarkerSize',10)
    hold off
end

