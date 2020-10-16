%%Symbolic solver
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
% disp(T);

%T = vpa(subs(T,A(3,1),0),4);

ch1 = input('Enter 1 if you have variables in your table, 2 for constants: ');
if ch1 == 1
    while flg(4) == 0
        flg=input('Enter data as [position,value,1/0]: '); %constants filler
        T = vpa(subs(T,A(flg(1),flg(2)),flg(3)),4);
    end
    Tpos=[T(1,4),T(2,4),T(3,4)];
    %Tpost=Tpos;
    Tpost = matlabFunction(Tpos);
    var_index = input('Enter variable index: ');
    %elements = input('Enter lower:upper range: ');
    elements = {0,-1.9:0.5:1.9,-2.8:0.5:2.8,-0.9:0.5:3.14,-4.8:0.5:1.3,-1.6:0.5:1.6,-2.2:0.5:2.2}; %cell array with N vectors to combine
    combinations = cell(1, numel(elements)); %set up the varargout result
    [combinations{:}] = ndgrid(elements{:});
    combinations = cellfun(@(x) x(:), combinations,'uniformoutput',false); %there may be a better way to do this
    result = [combinations{:}]; % NumberOfCombinations by N matrix. Each row is unique.
    f(size(result,1),3) = 0;
    disp('end length');
    disp(size(result,1));
    
    for j=1:size(result,1)
        f(j,:)=Tpost(result(j,1),result(j,2),result(j,3),result(j,4),result(j,5),result(j,6),result(j,7));
    end
    
    disp('Done');
    
    
    %%disp(result);
%     for j=1:size(result,1)
%         for k=1:size(result,2)
%             
%             %Tpost = vpa(subs(Tpost,A(k,var_index(1,k)),result(j,k)),4);
%             
%             %%disp('$');
%         end
%         %%disp('#');
%         f(j,:)=simplify(Tpost);
%         %disp(f);
% %         plot3(f(1),f(2),f(3),'.r');
% %         hold on
%         if rem(j,5000)==0
%             disp(j)
%         end
%         Tpost = Tpos;
% end
    
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
else
end


