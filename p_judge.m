function TestResult=p_judge(A,alpha)
[mu,sigma]=normfit(A);
p1=normcdf(A,mu,sigma);
[H1,s1]=kstest(A,[A,p1],alpha);
n=length(A);
if H1==0
    disp('Gauss')
else
    disp('non Gauss')
end
phat=gamfit(A,alpha);
p2=gamcdf(A,phat(1),phat(2));
[H2,s2]=kstest(A,[A,p2],alpha);
if H2==0
    disp('Gamma')
else
    disp('non Gamma')
end
lamda=poissfit(A,alpha);
p3=poisscdf(A,lamda);
[H3,s3]=kstest(A,[A,p3],alpha);
if H3==0
    disp('Possion')
else
    disp('non Possion')
end
mu=expfit(A,alpha);
p4=expcdf(A,mu);
[H4,s4]=kstest(A,[A,p4],alpha);
if H4==0
    disp('exponential')
else
    disp('non exponential')
end
[phat, pci] = raylfit(A, alpha);
p5=raylcdf(A,phat);
[H5,s5]=kstest(A,[A,p5],alpha);
if H5==0
    disp('rayleigh ')
else
    disp('non rayleigh')
end

TestResult=[H1 H2 H3 H4 H5];

