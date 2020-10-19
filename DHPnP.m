%% Homogeneous Matrix Builder
noParams = input('Enter the number of axis: ');
T = [1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1];
flg = [0,0,0,0];
A = sym('A%d%d',[noParams,4]);
for i=1:1:noParams
    Rz = [cos(A(i,1)),-sin(A(i,1)),0,0;sin(A(i,1)),cos(A(i,1)),0,0;0,0,1,0;0,0,0,1];
    Tz = [1,0,0,0;0,1,0,0;0,0,1,A(i,2);0,0,0,1];
    Tx = [1,0,0,A(i,3);0,1,0,0;0,0,1,0;0,0,0,1];
    Rx = [1,0,0,0;0,cos(A(i,4)),-sin(A(i,4)),0;0,sin(A(i,4)),cos(A(i,4)),0;0,0,0,1];
    T = T*(Rz*Tz*Tx*Rx);
end
%% DH Parameter Substitutor 
ch1 = input('Enter 1 if you have variables in your table, 2 for constants: ');
if ch1 == 1
    while flg(4) == 0
        flg=input('Enter data as [position,value,1/0]: '); %constants filler
        T = vpa(subs(T,A(flg(1),flg(2)),flg(3)),4);
    end
    disp('Tool to Base Transformation Matrix created');
    disp(T);
    Tpos=[T(1,4),T(2,4),T(3,4)];
    Tpost = matlabFunction(Tpos);
%% Monte Carlo Generator    
    ch2=input('Press 1 if you want to plot the 3D workspace');
    if ch2 == 1 
        N = 67312;
        range=input('Enter upper and lower limits of each joint. EXCLUDE ROLL JOINTS');
        lim(N,size(range,1))=0;
        for i=1:size(range,1)
            lim(:,i) = range(i,1) + (range(i,2)-range(i,1))*rand(N,1);
        end
    end
%% Plot Points Collector
    f(size(lim,1),3) = 0;
    if size(range,1) == 2
        for j=1:size(lim,1)
            f(j,:)=Tpost(lim(j,1),lim(j,2));
        end
    elseif size(range,1) == 3
        for j=1:size(lim,1)
            f(j,:)=Tpost(lim(j,1),lim(j,2),lim(j,3));
        end
    elseif size(range,1) == 4
        for j=1:size(lim,1)
            f(j,:)=Tpost(lim(j,1),lim(j,2),lim(j,3),lim(j,4));
        end
    elseif size(range,1) == 5
        for j=1:size(lim,1)
            f(j,:)=Tpost(lim(j,1),lim(j,2),lim(j,3),lim(j,4),lim(j,5));
        end
    elseif size(range,1) == 6
        for j=1:size(lim,1)
            f(j,:)=Tpost(lim(j,1),lim(j,2),lim(j,3),lim(j,4),lim(j,5),lim(j,6));
        end
    elseif size(range,1) == 7
        for j=1:size(lim,1)
            f(j,:)=Tpost(lim(j,1),lim(j,2),lim(j,3),lim(j,4),lim(j,5),lim(j,6),lim(j,7));
        end
    elseif size(range,1) == 8
        for j=1:size(lim,1)
            f(j,:)=Tpost(lim(j,1),lim(j,2),lim(j,3),lim(j,4),lim(j,5),lim(j,6),lim(j,7),lim(j,8));
        end
    elseif size(range,1) == 9
        for j=1:size(lim,1)
            f(j,:)=Tpost(lim(j,1),lim(j,2),lim(j,3),lim(j,4),lim(j,5),lim(j,6),lim(j,7),lim(j,8),lim(j,9));
        end
    end
%% Workspace Plotter
    disp('Starting Workspace Plotter');
    for i=1:N
        plot3(f(i,1),f(i,2),f(i,3),'.')
        hold on;
    end
    view(3);
    title('Isometric view');
    xlabel('x (m)');
    ylabel('y (m)');
    zlabel('z (m) ');
    view(2); % top view
    title(' Top view');
    xlabel('x (m)');
    ylabel('y (m)');
    view([0 1 0]); % y-z plane
    title('Side view, Y-Z');
    ylabel('y (m)');
    zlabel('z (m)');

    disp('Plotting Complete');
    
%% Constant DH Parameter Solver     
elseif ch1 == 2
    for i=1:1:noParams 
    inp = input('Enter teta, d , a , alpha: ');
    if size(inp,2) ~= 4 
        disp('Wrong data entry found, please restart the code');
    else
        for j=1:1:4
            T = vpa(subs(T,A(i,j),inp(j)),4);
        end
    end
    end
    disp(T);    
end


