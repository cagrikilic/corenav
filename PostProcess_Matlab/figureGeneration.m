for ss=1:length(insLLH)
    xyz(:,ss)=llh2xyz(insLLH(:,ss));
    if gpsResults()
    gpsLongerXYZ(:,ss)=llh2xyz(gpsLonger(:,ss));
    end
    xyz_3P(:,ss)=llh2xyz([insLLH(1,ss)-sig7(ss);insLLH(2,ss)-sig8(ss);insLLH(3,ss)-sig9(ss)]);
    xyz3P(:,ss)=llh2xyz([insLLH(1,ss)+sig7(ss);insLLH(2,ss)+sig8(ss);insLLH(3,ss)+sig9(ss)]);
    ENU(:,ss)=xyz2enu(xyz(:,ss),xyzInit);
    ENU3P(:,ss)=xyz2enu(xyz3P(:,ss),xyzInit);
    ENU_3P(:,ss)=xyz2enu(xyz_3P(:,ss),xyzInit);

    xyz3(:,ss)=llh2xyz(insLLHCorr(:,ss));
    xyz3_3P(:,ss)=llh2xyz([insLLHCorr(1,ss)-sig7(ss);insLLHCorr(2,ss)-sig8(ss);insLLHCorr(3,ss)-sig9(ss)]);
    xyz33P(:,ss)=llh2xyz([insLLHCorr(1,ss)+sig7(ss);insLLHCorr(2,ss)+sig8(ss);insLLHCorr(3,ss)+sig9(ss)]);
    ENU3(:,ss)=xyz2enu(xyz3(:,ss),xyzInit);
    ENU33P(:,ss)=xyz2enu(xyz33P(:,ss),xyzInit);
    ENU3_3P(:,ss)=xyz2enu(xyz3_3P(:,ss),xyzInit);
end
for ss2=1:length(LLHcorrected)
    xyzCorrected(:,ss2)=llh2xyz(LLHcorrected(:,ss2));
    xyzCorrected_3P(:,ss2)=llh2xyz([LLHcorrected(1,ss2)-sig7(ss2);LLHcorrected(2,ss2)-sig8(ss2);LLHcorrected(3,ss2)-sig9(ss2)]);
    xyzCorrected3P(:,ss2)=llh2xyz([LLHcorrected(1,ss2)+sig7(ss2);LLHcorrected(2,ss2)+sig8(ss2);LLHcorrected(3,ss2)+sig9(ss2)]);
    ENUcorrected(:,ss2)=xyz2enu(xyzCorrected(:,ss2),xyzInit);
    ENU3Pcorrected(:,ss2)=xyz2enu(xyzCorrected3P(:,ss2),xyzInit);
    ENU_3Pcorrected(:,ss2)=xyz2enu(xyzCorrected_3P(:,ss2),xyzInit);
end
if odomUpdate
    for ss3=1:length(LLHcorrected2)
        xyzCorrected2(:,ss3)=llh2xyz(LLHcorrected2(:,ss3));
        ENUcorrected2(:,ss3)=xyz2enu(xyzCorrected2(:,ss3),xyzInit);
    end

    for ss4=1:length(LLHcorrected1)
        xyzCorrected1(:,ss4)=llh2xyz(LLHcorrected1(:,ss4));
        ENUcorrected1(:,ss4)=xyz2enu(xyzCorrected1(:,ss4),xyzInit);
    end
end
if gpsResults()
gpsLongerXYZ(:,1)=xyzInit;
RMSE_east=sqrt(mean((xyz(1,:)-gpsLongerXYZ(1,:)).^2)); %R Mean Squared Error
RMSE_north=sqrt(mean((xyz(2,:)-gpsLongerXYZ(2,:)).^2));   %R Mean Squared Error
RMSE_up=sqrt(mean((xyz(3,:)-gpsLongerXYZ(3,:)).^2));  %R Mean Squared Error
end
%%
xy_err=ENU33P(1:2,:)-ENU3(1:2,:);
for i=1:length(xy_err)
    dPx(1,i)=sqrt(xy_err(1:2,i)'*xy_err(1:2,i));
end
%%
if gpsResults
errXY=xyz(1:2,:)-gpsLongerXYZ(1:2,:);
for i=1:length(errXY)
    dPx2(1,i)=sqrt(errXY(1:2,i)'*errXY(1:2,i));
end

medHor=median(dPx2)
stdHor=std(dPx2)
maxHor=max(dPx2)

RMSE_e=sqrt(mean((xyz(1,:)-gpsLongerXYZ(1,:)).^2)) %R Mean Squared Error
RMSE_n=sqrt(mean((xyz(2,:)-gpsLongerXYZ(2,:)).^2))   %R Mean Squared Error
RMSE_u=sqrt(mean((xyz(3,:)-gpsLongerXYZ(3,:)).^2))  %R Mean Squared Error
end
figGen
% hold off
% ellipsegen
% hampel(mahala,50)
% figure;
% plot(slipR)
% ylim([-1,1])
% figure;
% plot(slipF)
% ylim([-1,1])
% hold off
% gpsLongerXYZ(1,1)=856507.849400000;

% h(8)=figure;
% plot(tTimu(1:end-1,1)-tTimu(1),ENU33P(1,:)-ENU3(1,:),'-.k','DisplayName','3sigma')
% hold on
% plot(tTimu(1:end-1,1)-tTimu(1),abs(xyz3(1,:)-gpsLongerXYZ(1,:)),'','DisplayName','abs(lln-gps)')
% ylabel('x_{err}(m)')
% xlabel('time')
% legend('show');
% h(9)=figure;
% plot(tTimu(1:end-1,1)-tTimu(1),ENU33P(2,:)-ENU3(2,:),'-.k','DisplayName','3sigma')
% hold on
% plot(tTimu(1:end-1,1)-tTimu(1),abs(xyz3(2,:)-gpsLongerXYZ(2,:)),'','DisplayName','abs(lln-gps)')
% ylabel('y_{err}(m)')
% xlabel('time')
% legend('show');
% figure;plot(tTimu(1:end-1,1)-tTimu(1),dPx)
% figure;plot(tTimu(1:end-1,1)-tTimu(1),dPx2)
