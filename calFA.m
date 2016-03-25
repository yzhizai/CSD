function FA = calFA(DT)

meanLambda = trace(DT)/3;
[~, D] = eig(DT);

Lambda = sort(diag(D), 'descend');

lambda1 = Lambda(1);
lambda2 = Lambda(2);
lambda3 = Lambda(3);

FA = sqrt(3/2)*sqrt((lambda1 - meanLambda)^2 + (lambda2 - meanLambda)^2 + (lambda3 - meanLambda)^2)/sqrt(lambda1^2 + lambda2^2 + lambda3^2);

