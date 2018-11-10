function [ tax ] = taxCalculator(taxableIncome,period)
%taxCalculator This function caluclates the taxes on taxable income in 
% California for the 2018 tax year.
%% 2018 California Tax Brackets
%   Tax Bracket%%%%Tax Rate
%       0+          1%
%       8015+       2%
%       19001+      4%
%       29989+      6%
%       41629+      8%
%       52612+      9.3%
%       268750+     10.3%
%       322499+     11.3%
%       537498+     12.3%
%       1000000+    13.3%
%% 2018 Federal Tax Brackets
%       0+          10%
%       9525+       12%
%       38700+      22%
%       82500+      24%
%       157500+     32%
%       200000+     35%
%       500000+     37%
%% 2018 FICA
% 6.25% Social Security
% 1.45% Medicare
%% 
in = taxableIncome;
stateTax = 0;
federalTax = 0;
cTax18 = ...
    [0 1
    8015 2
    19001 4
    29989 6
    41629 8 
    52612 9.3
    268750 10.3
    322499 11.3
    537498 12.3
    1000000 13.3];
fTax18 = ...
    [0 10
    9525 12
    38700 22
    82500 24
    157500 32
    200000 35
    500000 37];
switch period
    case 'annual'
        cTax18(:,1) = cTax18(:,1);
        fTax18(:,1) = fTax18(:,1);
    case 'ppp'
        cTax18(:,1) = cTax18(:,1)/26;
        fTax18(:,1) = fTax18(:,1)/26;
end
for i=1:numel(cTax18(:,1))-1
    if in>=cTax18(i,1) && in>=cTax18(i+1,1)
        stateTax = stateTax + (cTax18(i+1,1)-cTax18(i,1))*cTax18(i,2)/100
        disp('1')
    end
    if in>=cTax18(i,1) && in<cTax18(i+1,1)
        stateTax = stateTax + (in-cTax18(i,1))*cTax18(i,2)/100
        disp('2')
    elseif in>=cTax18(end,1)
        stateTax = stateTax + (in-cTax18(end,1))*cTax18(end,2)/100
        disp('3')
        break
    end
end
for j=1:numel(fTax18(:,1))-1
    if in>=fTax18(j,1) && in>=fTax18(j+1,1)
        federalTax = federalTax + (fTax18(j+1,1)-fTax18(j,1))*fTax18(j,2)/100
        disp('1')
    end
    if in>=fTax18(j,1) && in<fTax18(j+1,1)
        federalTax = federalTax + (in-fTax18(j,1))*fTax18(j,2)/100
        disp('2')
    elseif in>=fTax18(end,1)
        federalTax = federalTax + (in-fTax18(end,1))*fTax18(end,2)/100
        disp('3')
        break
    end
end
medicareTax = in*1.45/100
socialSecurityTax = in*6.25/100
tax = stateTax + federalTax + medicareTax + socialSecurityTax;
