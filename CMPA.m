%Justin Park 101013156
%CMPA

%------------------------------------
Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;

V = linspace(-1.95, 0.7, 200);
I = Is*(exp(1.2*V/0.025) - 1) + Gp*V - Ib*(exp((-1.2/0.025)*(V+Vb)) - 1);
I_rand = I+randn(length(V), 1)'.*0.2*I;

%--------------------------------
I_poly4=polyfit(V,I1,4);
I_poly8=polyfit(V,I1,8);
y4=polyval(p14,V);
y18=polyval(p18,V);

p24=polyfit(V,I2,4);
p28=polyfit(V,I2,8);
y24=polyval(p24,V);
y28=polyval(p28,V);

fo1=fittype('A.*(exp(1.2*x/25e-3)-1)+B.*x-C*(exp(1.2*(-(x+D))/25e-3)-1)');
ff1=fit(V',I1',fo1);
If1=ff1(V);

fo2=fittype('A.*(exp(1.2*x/25e-3)-1)+0.1.*x-C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff2=fit(V',I1',fo2);
If2=ff2(V);

fo3=fittype('A.*(exp(1.2*x/25e-3)-1)+B.*x-C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff3=fit(V',I1',fo3);
If3=ff3(V);

fo4=fittype('A.*(exp(1.2*x/25e-3)-1)+B.*x-C*(exp(1.2*(-(x+D))/25e-3)-1)');
ff4=fit(V',I2',fo4);
If4=ff4(V);

fo5=fittype('A.*(exp(1.2*x/25e-3)-1)+0.1.*x-C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff5=fit(V',I2',fo5);
If5=ff5(V);

fo6=fittype('A.*(exp(1.2*x/25e-3)-1)+B.*x-C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ff6=fit(V',I2',fo6);
If6=ff6(V);

inputs = V.';
targets = I1.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
view(net);
Inn = outputs;









