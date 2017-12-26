clear all;clc;
%%
%数据准备
 data=[1104,460;
     1204,460;
     1304,460;
     1416,232;
     1534,315;
     1300,1178];%第一列是房子大小，第二列是价格
X=data(:,1);
y=data(:,2);
m=length(y);

plot(X, y, 'rx', 'MarkerSize', 10); % Plot the data
ylabel('Price in $1000s'); % Set the y?axis label
xlabel('Size feet2'); % Set the x?axis label

X=[ones(m,1),data(:,1)];
theta=zeros(2,1);%是zeros，不是zero
iterations=1000;
alpha=0.001;
num_iters=1000;
%%
%coustFunction
h=X*theta;%最好分开求h？
J=sum(1/(2*m)*((h-y).^2));


%%
%梯度下降
J_history = zeros(num_iters, 1);

for iter = 1:num_iters
    
theta=theta-alpha/m*X'*(h-y);%theta什么时候带（iter）？？？什么时候不带呢？
    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);

end
%%  Plot the linear fit
hold on; % keep previous plot visible
plot(X(:,2), X*theta, '-')
legend('Training data', 'Linear regression')
hold off % don't overlay any more plots on this figure

% Predict values for population sizes of 35,000 and 70,000
predict1 = [1, 3.5] *theta;
fprintf('For population = 35,000, we predict a profit of %f\n',...
    predict1*10000);
predict2 = [1, 7] * theta;
fprintf('For population = 70,000, we predict a profit of %f\n',...
    predict2*10000);

fprintf('Program paused. Press enter to continue.\n');
pause;
%% ============= Part 4: Visualizing J(theta_0, theta_1) =============
fprintf('Visualizing J(theta_0, theta_1) ...\n')

% Grid over which we will calculate J
theta0_vals = linspace(-10, 10, 100);
theta1_vals = linspace(-1, 4, 100);

% initialize J_vals to a matrix of 0's
J_vals = zeros(length(theta0_vals), length(theta1_vals));

% Fill out J_vals
for i = 1:length(theta0_vals)
    for j = 1:length(theta1_vals)
	  t = [theta0_vals(i); theta1_vals(j)];
	  J_vals(i,j) = computeCost(X, y, t);
    end
end


% Because of the way meshgrids work in the surf command, we need to
% transpose J_vals before calling surf, or else the axes will be flipped
J_vals = J_vals';
% Surface plot
figure;
surf(theta0_vals, theta1_vals, J_vals)
xlabel('\theta_0'); ylabel('\theta_1');

% Contour plot
figure;
% Plot J_vals as 15 contours spaced logarithmically between 0.01 and 100
contour(theta0_vals, theta1_vals, J_vals, logspace(-2, 3, 20))
xlabel('\theta_0'); ylabel('\theta_1');
hold on;
plot(theta(1), theta(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
