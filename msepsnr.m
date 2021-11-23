function [MSE,PSNR]=msepsnr(A,ref)

PSNR = psnr(A,ref);
MSE = immse(A,ref);

%fprintf('MSE = %f\n',MSE);
disp(['The value of MSE is:  ' num2str(MSE)]);
%fprintf('PSNR = %f\n',PSNR);
disp(['The value of PSNR is:  ' num2str(PSNR)]);
end