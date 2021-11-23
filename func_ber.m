function [ hasil] = func_ber(x,y)

x = double(x);
y = double(y);

x = de2bi(x);
y = de2bi(y);

hasil = biterr(x,y);
%fprintf('BER = %f\n',hasil);
disp(['The value of BER is:  ' num2str(hasil)]);

end

