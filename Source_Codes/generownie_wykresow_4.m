clear all
close all

load('Szum_size_4.mat');
t = [1:31];

% Porównania wykonane s¹ dla jednego randomowego uk³adu z ró¿nymi
% parametreami

% one is enough, i checkes all are the same (OK)
y_oryg_chart = (reshape(y_oryg_b(10,1,1,2,:), 1, length(y_oryg_b(2,1,1,2,:))))';

% shownig 5 types of noise, again the same for every set
y_noise_chart = (reshape(y_oryg_b(10,1:5,1,2,:), 5, length(y_oryg_b(2,1:5,1,2,:))))';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PRZEKRJ METRYKI DLA RÓ¯NYCH WARTOŒCI ZASZUMIENIA (reszta sta³a)
% MAE
% zak³ócenia, nie powinny mieæ du¿ego wp³ywu na wygl¹d wykresu 
MAE_b_noise_10 = (reshape(MAE_b(10,1:20,1,5), 1, length(MAE_b(2,1:20,1,5))))';
MAE_era_noise_10 = (reshape(MAE_era(10,1:20,1,5), 1, length(MAE_era(2,1:20,1,5))))';
MAE_b_noise_11 = (reshape(MAE_b(11,1:20,1,5), 1, length(MAE_b(2,1:20,1,5))))';
MAE_era_noise_11 = (reshape(MAE_era(11,1:20,1,5), 1, length(MAE_era(2,1:20,1,5))))';
MAE_b_noise_12 = (reshape(MAE_b(12,1:20,1,5), 1, length(MAE_b(2,1:20,1,5))))';
MAE_era_noise_12 = (reshape(MAE_era(12,1:20,1,5), 1, length(MAE_era(2,1:20,1,5))))';
t = [1:20]*0.01;

figure()
subplot(3,1,1)
hold on
scatter(t,MAE_b_noise_10,'MarkerFaceColor','b','MarkerEdgeColor','k');
scatter(t,MAE_era_noise_10,'MarkerFaceColor','r','MarkerEdgeColor','k')
title('MAE model 10, for changing noise size')
legend('Hybrid', 'ERA');xlabel('Max noise level [percentage of max signal value]');ylabel('MAE');
grid on
subplot(3,1,2)
hold on
scatter(t,MAE_b_noise_11,'MarkerFaceColor','b','MarkerEdgeColor','k');
scatter(t,MAE_era_noise_11,'MarkerFaceColor','r','MarkerEdgeColor','k')
title('MAE model 11, for changing noise size')
legend('Hybrid', 'ERA');xlabel('Max noise level [percentage of max signal value]');ylabel('MAE');
grid on
subplot(3,1,3)
hold on
scatter(t,MAE_b_noise_12,'MarkerFaceColor','b','MarkerEdgeColor','k');
scatter(t,MAE_era_noise_12,'MarkerFaceColor','r','MarkerEdgeColor','k')
title('MAE model 12, for changing noise size')
legend('Hybrid', 'ERA');xlabel('Max noise level [percentage of max signal value]');ylabel('MAE');
grid on

% % RMSE
% RMSE_b_noise_10 = (reshape(RMSE_b(10,1:20,1,5), 1, length(RMSE_b(2,1:20,1,5))))';
% RMSE_era_noise_10 = (reshape(RMSE_era(10,1:20,1,5), 1, length(RMSE_era(2,1:20,1,5))))';
% RMSE_b_noise_11 = (reshape(RMSE_b(11,1:20,1,5), 1, length(RMSE_b(2,1:20,1,5))))';
% RMSE_era_noise_11 = (reshape(RMSE_era(11,1:20,1,5), 1, length(RMSE_era(2,1:20,1,5))))';
% RMSE_b_noise_12 = (reshape(RMSE_b(12,1:20,1,5), 1, length(RMSE_b(2,1:20,1,5))))';
% RMSE_era_noise_12 = (reshape(RMSE_era(12,1:20,1,5), 1, length(RMSE_era(2,1:20,1,5))))';
% t = [1:20]*0.01;
% 
% figure()
% subplot(3,1,1)
% hold on
% scatter(t,RMSE_b_noise_10,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,RMSE_era_noise_10,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('RMSE uk³adu 10, dla kolejnych zaszumieñ')
% legend('Fusion', 'ERA', 'Location', 'northwest');xlabel('Próba');ylabel('MAE');
% grid on
% subplot(3,1,2)
% hold on
% scatter(t,RMSE_b_noise_11,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,RMSE_era_noise_11,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('RMSE uk³adu 11, dla kolejnych zaszumieñ')
% legend('Fusion', 'ERA', 'Location', 'northwest');xlabel('Próba');ylabel('MAE');
% grid on
% subplot(3,1,3)
% hold on
% scatter(t,RMSE_b_noise_12,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,RMSE_era_noise_12,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('RMSE uk³adu 12, dla kolejnych zaszumieñ')
% legend('Fusion', 'ERA', 'Location', 'northwest');xlabel('Próba');ylabel('MAE');
% grid on
% 
% % norma frobeniusa wyliczona z dla
% % fusion - orygina³ 
% % era - orygina³ 
% % fusion - era
% h_f_o_noise_10 = []; h_e_o_noise_10 = []; h_f_e_noise_10 = [];
% h_f_o_noise_11 = []; h_e_o_noise_11 = []; h_f_e_noise_11 = [];
% h_f_o_noise_12 = []; h_e_o_noise_12 = []; h_f_e_noise_12 = [];
%     
% for i = 1:20 
%     h_f_o_noise_10(i) = norm(reshape(h_final_b(10,i,1,5,:), 1, length(h_final_b(10,i,1,5,:))) - reshape(h_oryginal_b(10,i,1,5,:), 1, length(h_oryginal_b(10,i,1,5,:))), 'fro');
%     h_e_o_noise_10(i) = norm(reshape(h_final_era(10,i,1,5,:), 1, length(h_final_era(10,i,1,5,:))) - reshape(h_oryginal_era(10,i,1,5,:), 1, length(h_oryginal_era(10,i,1,5,:))), 'fro');
%     h_f_e_noise_10(i) = norm(reshape(h_final_era(10,i,1,5,:), 1, length(h_final_era(10,i,1,5,:))) - reshape(h_final_b(10,i,1,5,:), 1, length(h_final_b(10,i,1,5,:))), 'fro');
%     
%     h_f_o_noise_11(i) = norm(reshape(h_final_b(11,i,1,5,:), 1, length(h_final_b(11,i,1,5,:))) - reshape(h_oryginal_b(11,i,1,5,:), 1, length(h_oryginal_b(11,i,1,5,:))), 'fro');
%     h_e_o_noise_11(i) = norm(reshape(h_final_era(11,i,1,5,:), 1, length(h_final_era(11,i,1,5,:))) - reshape(h_oryginal_era(11,i,1,5,:), 1, length(h_oryginal_era(11,i,1,5,:))), 'fro');
%     h_f_e_noise_11(i) = norm(reshape(h_final_era(11,i,1,5,:), 1, length(h_final_era(11,i,1,5,:))) - reshape(h_final_b(11,i,1,5,:), 1, length(h_final_b(11,i,1,5,:))), 'fro');
%     
%     h_f_o_noise_12(i) = norm(reshape(h_final_b(12,i,1,5,:), 1, length(h_final_b(12,i,1,5,:))) - reshape(h_oryginal_b(12,i,1,5,:), 1, length(h_oryginal_b(12,i,1,5,:))), 'fro');
%     h_e_o_noise_12(i) = norm(reshape(h_final_era(12,i,1,5,:), 1, length(h_final_era(12,i,1,5,:))) - reshape(h_oryginal_era(12,i,1,5,:), 1, length(h_oryginal_era(12,i,1,5,:))), 'fro');
%     h_f_e_noise_12(i) = norm(reshape(h_final_era(12,i,1,5,:), 1, length(h_final_era(12,i,1,5,:))) - reshape(h_final_b(12,i,1,5,:), 1, length(h_final_b(12,i,1,5,:))), 'fro');
% end
% 
% figure()
% subplot(3,1,1)
% hold on
% scatter(t,h_f_o_noise_10,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,h_e_o_noise_10,'MarkerFaceColor','r','MarkerEdgeColor','k');
% scatter(t,h_f_e_noise_10,'MarkerFaceColor','g','MarkerEdgeColor','k');
% title('Frobenius parametrów Markova uk³adu 10, dla kolejnych zaszumieñ')
% legend('F-O', 'E-O', 'F-E');xlabel('Próba');ylabel('RMSE');
% grid on
% subplot(3,1,2)
% hold on
% scatter(t,h_f_o_noise_11,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,h_e_o_noise_11,'MarkerFaceColor','r','MarkerEdgeColor','k');
% scatter(t,h_f_e_noise_11,'MarkerFaceColor','g','MarkerEdgeColor','k');
% title('Frobenius parametrów Markova uk³adu 11, dla kolejnych zaszumieñ')
% legend('F-O', 'E-O', 'F-E');xlabel('Próba');ylabel('RMSE');
% grid on
% subplot(3,1,3)
% hold on
% scatter(t,h_f_o_noise_12,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,h_e_o_noise_12,'MarkerFaceColor','r','MarkerEdgeColor','k');
% scatter(t,h_f_e_noise_12,'MarkerFaceColor','g','MarkerEdgeColor','k');
% title('Frobenius parametrów Markova uk³adu 12, dla kolejnych zaszumieñ')
% legend('F-O', 'E-O', 'F-E');xlabel('Próba');ylabel('RMSE');
% grid on

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % PRZEKRÓJ METRYK DLA RÓ¯NYCH WARTOŒCI CIÊCIA (reszta sta³a)
% % MAE
% % zak³ócenia, nie powinny mieæ du¿ego wp³ywu na wygl¹d wykresu 
% MAE_b_cut_10 = (reshape(MAE_b(10,1,1,2:7), 1, length(MAE_b(2,1,1,2:7))))';
% MAE_era_cut_10 = (reshape(MAE_era(10,1,1,2:7), 1, length(MAE_era(2,1,1,2:7))))';
% MAE_b_cut_11 = (reshape(MAE_b(11,1,1,2:7), 1, length(MAE_b(2,1,1,2:7))))';
% MAE_era_cut_11 = (reshape(MAE_era(11,1,1,2:7), 1, length(MAE_era(2,1,1,2:7))))';
% MAE_b_cut_12 = (reshape(MAE_b(12,1,1,2:7), 1, length(MAE_b(2,1,1,2:7))))';
% MAE_era_cut_12 = (reshape(MAE_era(12,1,1,2:7), 1, length(MAE_era(2,1,1,2:7))))';
% t = [2:7];
% 
% figure()
% subplot(3,1,1)
% hold on
% scatter(t,MAE_b_cut_10,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,MAE_era_cut_10,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('MAE uk³adu 10, dla wyciêæ macierzy')
% legend('Fusion', 'ERA');xlabel('Rz¹d');ylabel('MAE');
% grid on
% subplot(3,1,2)
% hold on
% scatter(t,MAE_b_cut_11,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,MAE_era_cut_11,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('MAE uk³adu 11, dla wyciêæ macierzy')
% legend('Fusion', 'ERA');xlabel('Rz¹d');ylabel('MAE');
% grid on
% subplot(3,1,3)
% hold on
% scatter(t,MAE_b_cut_12,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,MAE_era_cut_12,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('MAE uk³adu 12, dla wyciêæ macierzy')
% legend('Fusion', 'ERA');xlabel('Rz¹d');ylabel('MAE');
% grid on
% 
% % RMSE
% RMSE_b_cut_10 = (reshape(RMSE_b(10,1,1,2:7), 1, length(RMSE_b(2,1,1,2:7))))';
% RMSE_era_cut_10 = (reshape(RMSE_era(10,1,1,2:7), 1, length(RMSE_era(2,1,1,2:7))))';
% RMSE_b_cut_11 = (reshape(RMSE_b(11,1,1,2:7), 1, length(RMSE_b(2,1,1,2:7))))';
% RMSE_era_cut_11 = (reshape(RMSE_era(11,1,1,2:7), 1, length(RMSE_era(2,1,1,2:7))))';
% RMSE_b_cut_12 = (reshape(RMSE_b(12,1,1,2:7), 1, length(RMSE_b(2,1,1,2:7))))';
% RMSE_era_cut_12 = (reshape(RMSE_era(12,1,1,2:7), 1, length(RMSE_era(2,1,1,2:7))))';
% t = [2:7];
% 
% figure()
% subplot(3,1,1)
% hold on
% scatter(t,RMSE_b_cut_10,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,RMSE_era_cut_10,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('RMSE uk³adu 10, dla wyciêæ macierzy')
% legend('Fusion', 'ERA');xlabel('Rz¹d');ylabel('MAE');
% grid on
% subplot(3,1,2)
% hold on
% scatter(t,RMSE_b_cut_11,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,RMSE_era_cut_11,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('RMSE uk³adu 11, dla wyciêæ macierzy')
% legend('Fusion', 'ERA');xlabel('Rz¹d');ylabel('MAE');
% grid on
% subplot(3,1,3)
% hold on
% scatter(t,RMSE_b_cut_12,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,RMSE_era_cut_12,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('RMSE uk³adu 12, dla wyciêæ macierzy')
% legend('Fusion', 'ERA');xlabel('Rz¹d');ylabel('MAE');
% grid on
% 
% % norma frobeniusa wyliczona z dla
% % fusion - orygina³ 
% % era - orygina³ 
% % fusion - era
% h_f_o_cut_10 = []; h_e_o_cut_10 = []; h_f_e_cut_10 = [];
% h_f_o_cut_11 = []; h_e_o_cut_11 = []; h_f_e_cut_11 = [];
% h_f_o_cut_12 = []; h_e_o_cut_12 = []; h_f_e_cut_12 = [];
%     
% for i = 2:7 
%     h_f_o_cut_10(i) = norm(reshape(h_final_b(10,1,1,i,:), 1, length(h_final_b(10,1,1,i,:))) - reshape(h_oryginal_b(10,1,1,i,:), 1, length(h_oryginal_b(10,1,1,i,:))), 'fro');
%     h_e_o_cut_10(i) = norm(reshape(h_final_era(10,1,1,i,:), 1, length(h_final_era(10,1,1,i,:))) - reshape(h_oryginal_era(10,1,1,i,:), 1, length(h_oryginal_era(10,1,1,i,:))), 'fro');
%     h_f_e_cut_10(i) = norm(reshape(h_final_era(10,1,1,i,:), 1, length(h_final_era(10,1,1,i,:))) - reshape(h_final_b(10,1,1,i,:), 1, length(h_final_b(10,1,1,i,:))), 'fro');
%     
%     h_f_o_cut_11(i) = norm(reshape(h_final_b(11,1,1,i,:), 1, length(h_final_b(11,1,1,i,:))) - reshape(h_oryginal_b(11,1,1,i,:), 1, length(h_oryginal_b(11,1,1,i,:))), 'fro');
%     h_e_o_cut_11(i) = norm(reshape(h_final_era(11,1,1,i,:), 1, length(h_final_era(11,1,1,i,:))) - reshape(h_oryginal_era(11,1,1,i,:), 1, length(h_oryginal_era(11,1,1,i,:))), 'fro');
%     h_f_e_cut_11(i) = norm(reshape(h_final_era(11,1,1,i,:), 1, length(h_final_era(11,1,1,i,:))) - reshape(h_final_b(11,1,1,i,:), 1, length(h_final_b(11,1,1,i,:))), 'fro');
% 
%     h_f_o_cut_12(i) = norm(reshape(h_final_b(12,1,1,i,:), 1, length(h_final_b(12,1,1,i,:))) - reshape(h_oryginal_b(12,1,1,i,:), 1, length(h_oryginal_b(12,1,1,i,:))), 'fro');
%     h_e_o_cut_12(i) = norm(reshape(h_final_era(12,1,1,i,:), 1, length(h_final_era(12,1,1,i,:))) - reshape(h_oryginal_era(12,1,1,i,:), 1, length(h_oryginal_era(12,1,1,i,:))), 'fro');
%     h_f_e_cut_12(i) = norm(reshape(h_final_era(12,1,1,i,:), 1, length(h_final_era(12,1,1,i,:))) - reshape(h_final_b(12,1,1,i,:), 1, length(h_final_b(12,1,1,i,:))), 'fro');
% end
% 
% figure()
% subplot(3,1,1)
% hold on
% scatter(t,h_f_o_cut_10(2:7),'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,h_e_o_cut_10(2:7),'MarkerFaceColor','r','MarkerEdgeColor','k');
% scatter(t,h_f_e_cut_10(2:7),'MarkerFaceColor','g','MarkerEdgeColor','k');
% title('Frobenius parametrów Markova uk³adu 10, dla wyciêæ macierzy')
% legend('F-O', 'E-O', 'F-E');xlabel('Rz¹d');ylabel('Fro');
% grid on
% subplot(3,1,2)
% hold on
% scatter(t,h_f_o_cut_11(2:7),'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,h_e_o_cut_11(2:7),'MarkerFaceColor','r','MarkerEdgeColor','k');
% scatter(t,h_f_e_cut_11(2:7),'MarkerFaceColor','g','MarkerEdgeColor','k');
% title('Frobenius parametrów Markova uk³adu 11, dla wyciêæ macierzy')
% legend('F-O', 'E-O', 'F-E');xlabel('Rz¹d');ylabel('Fro');
% grid on
% subplot(3,1,3)
% hold on
% scatter(t,h_f_o_cut_12(2:7),'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,h_e_o_cut_12(2:7),'MarkerFaceColor','r','MarkerEdgeColor','k');
% scatter(t,h_f_e_cut_12(2:7),'MarkerFaceColor','g','MarkerEdgeColor','k');
% title('Frobenius parametrów Markova uk³adu 12, dla wyciêæ macierzy')
% legend('F-O', 'E-O', 'F-E');xlabel('Rz¹d');ylabel('Fro');
% grid on
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % PRZEKRÓJ METRYK DLA RÓ¯NYCH WARTOŒCI EPSILON (reszta sta³a)
% % MAE
% MAE_b_eps_10 = (reshape(MAE_b(10,1,1:11,5), 1, length(MAE_b(2,1,1:11,5))));
% MAE_era_eps_10 = (reshape(MAE_era(10,1:11,1,5), 1, length(MAE_era(2,1,1:11,5))));
% MAE_b_eps_11 = (reshape(MAE_b(11,1,1:11,5), 1, length(MAE_b(2,1,1:11,5))));
% MAE_era_eps_11 = (reshape(MAE_era(11,1,1:11,5), 1, length(MAE_era(2,1,1:11,5))));
% MAE_b_eps_12 = (reshape(MAE_b(12,1,1:11,5), 1, length(MAE_b(2,1,1:11,5))));
% MAE_era_eps_12 = (reshape(MAE_era(12,1,1:11,5), 1, length(MAE_era(2,1,1:11,5))));
% t = [0:0.1:1];
% 
% figure()
% subplot(3,1,1)
% hold on
% scatter(t,MAE_b_eps_10,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,MAE_era_eps_10,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('MAE uk³adu 10, dla watortoœci epsilon')
% legend('Fusion', 'ERA');xlabel('Epsilon');ylabel('MAE');
% grid on
% subplot(3,1,2)
% hold on
% scatter(t,MAE_b_eps_11,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,MAE_era_eps_11,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('MAE uk³adu 11, dla watortoœci epsilon')
% legend('Fusion', 'ERA');xlabel('Epsilon');ylabel('MAE');
% grid on
% subplot(3,1,3)
% hold on
% scatter(t,MAE_b_eps_12,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,MAE_era_eps_12,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('MAE uk³adu 12, dla watortoœci epsilon')
% legend('Fusion', 'ERA');xlabel('Epsilon');ylabel('MAE');
% grid on
% 
% %RMSE
% RMSE_b_eps_10 = (reshape(RMSE_b(10,1,1:11,5), 1, length(RMSE_b(2,1,1:11,5))));
% RMSE_era_eps_10 = (reshape(RMSE_era(10,1:11,1,5), 1, length(RMSE_era(2,1,1:11,5))));
% RMSE_b_eps_11 = (reshape(RMSE_b(11,1,1:11,5), 1, length(RMSE_b(2,1,1:11,5))));
% RMSE_era_eps_11 = (reshape(RMSE_era(11,1,1:11,5), 1, length(RMSE_era(2,1,1:11,5))));
% RMSE_b_eps_12 = (reshape(RMSE_b(12,1,1:11,5), 1, length(RMSE_b(2,1,1:11,5))));
% RMSE_era_eps_12 = (reshape(RMSE_era(12,1,1:11,5), 1, length(RMSE_era(2,1,1:11,5))));
% t = [0:0.1:1];
% 
% figure()
% subplot(3,1,1)
% hold on
% scatter(t,RMSE_b_eps_10,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,RMSE_era_eps_10,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('RMSE uk³adu 10, dla watortoœci epsilon')
% legend('Fusion', 'ERA');xlabel('Epsilon');ylabel('MAE');
% grid on
% subplot(3,1,2)
% hold on
% scatter(t,RMSE_b_eps_11,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,RMSE_era_eps_11,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('RMSE uk³adu 11, dla watortoœci epsilon')
% legend('Fusion', 'ERA');xlabel('Epsilon');ylabel('MAE');
% grid on
% subplot(3,1,3)
% hold on
% scatter(t,RMSE_b_eps_12,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,RMSE_era_eps_12,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('RMSE uk³adu 12, dla watortoœci epsilon')
% legend('Fusion', 'ERA');xlabel('Epsilon');ylabel('MAE');
% grid on
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % OPTYMALNY RZ¥D ZALE¯NY OD EPSILON (tutaj to ¿e do wyboru wzi¹³em 5 rank
% % nie ma znaczenia, bo wyœwietlam rank po optymalizacji, który zalezy tylk 
% % od algorytmu)
% rank_b_eps_10 = (reshape(rank_opt_b(10,1,1:11,5), 1, length(rank_opt_b(2,1,1:11,5))));
% rank_era_eps_10 = (reshape(rank_opt_era(10,1:11,1,5), 1, length(rank_opt_era(2,1,1:11,5))));
% rank_b_eps_11 = (reshape(rank_opt_b(11,1,1:11,5), 1, length(rank_opt_b(2,1,1:11,5))));
% rank_era_eps_11 = (reshape(rank_opt_era(11,1,1:11,5), 1, length(rank_opt_era(2,1,1:11,5))));
% rank_b_eps_12 = (reshape(rank_opt_b(12,1,1:11,5), 1, length(rank_opt_b(2,1,1:11,5))));
% rank_era_eps_12 = (reshape(rank_opt_era(12,1,1:11,5), 1, length(rank_opt_era(2,1,1:11,5))));
% t = [0:0.1:1];
% 
% figure()
% subplot(3,1,1)
% hold on
% scatter(t,rank_b_eps_10,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,rank_era_eps_10,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('Rz¹d uk³adu 10, dla watortoœci epsilon')
% legend('Fusion', 'ERA');xlabel('Epsilon');ylabel('Rz¹d');
% grid on
% subplot(3,1,2)
% hold on
% scatter(t,rank_b_eps_11,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,rank_era_eps_11,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('Rz¹d uk³adu 11, dla watortoœci epsilon')
% legend('Fusion', 'ERA');xlabel('Epsilon');ylabel('Rz¹d');
% grid on
% subplot(3,1,3)
% hold on
% scatter(t,rank_b_eps_12,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,rank_era_eps_12,'MarkerFaceColor','r','MarkerEdgeColor','k')
% title('Rz¹d uk³adu 12, dla watortoœci epsilon')
% legend('Fusion', 'ERA');xlabel('Epsilon');ylabel('Rz¹d');
% grid on
% 
% % norma frobeniusa wyliczona z dla
% % fusion - orygina³ 
% % era - orygina³ 
% % fusion - era
% h_f_o_eps_10 = []; h_e_o_eps_10 = []; h_f_e_eps_10 = [];
% h_f_o_eps_11 = []; h_e_o_eps_11 = []; h_f_e_eps_11 = [];
% h_f_o_eps_12 = []; h_e_o_eps_12 = []; h_f_e_eps_12 = [];
%     
% for i = 1:11 
%     h_f_o_eps_10(i) = norm(reshape(h_final_b(10,1,i,5,:), 1, length(h_final_b(10,1,i,5,:))) - reshape(h_oryginal_b(10,1,i,5,:), 1, length(h_oryginal_b(10,1,i,5,:))), 'fro');
%     h_e_o_eps_10(i) = norm(reshape(h_final_era(10,1,i,5,:), 1, length(h_final_era(10,1,i,5,:))) - reshape(h_oryginal_era(10,1,i,5,:), 1, length(h_oryginal_era(10,1,i,5,:))), 'fro');
%     h_f_e_eps_10(i) = norm(reshape(h_final_era(10,1,i,5,:), 1, length(h_final_era(10,1,i,5,:))) - reshape(h_final_b(10,1,i,5,:), 1, length(h_final_b(10,1,i,5,:))), 'fro');
%     
%     h_f_o_eps_11(i) = norm(reshape(h_final_b(11,1,i,5,:), 1, length(h_final_b(11,1,i,5,:))) - reshape(h_oryginal_b(11,1,i,5,:), 1, length(h_oryginal_b(11,1,i,5,:))), 'fro');
%     h_e_o_eps_11(i) = norm(reshape(h_final_era(11,1,i,5,:), 1, length(h_final_era(11,1,i,5,:))) - reshape(h_oryginal_era(11,1,i,5,:), 1, length(h_oryginal_era(11,1,i,5,:))), 'fro');
%     h_f_e_eps_11(i) = norm(reshape(h_final_era(11,1,i,5,:), 1, length(h_final_era(11,1,i,5,:))) - reshape(h_final_b(11,1,i,5,:), 1, length(h_final_b(11,1,i,5,:))), 'fro');
%     
%     h_f_o_eps_12(i) = norm(reshape(h_final_b(12,1,i,5,:), 1, length(h_final_b(12,1,i,5,:))) - reshape(h_oryginal_b(12,1,i,5,:), 1, length(h_oryginal_b(12,1,i,5,:))), 'fro');
%     h_e_o_eps_12(i) = norm(reshape(h_final_era(12,1,i,5,:), 1, length(h_final_era(12,1,i,5,:))) - reshape(h_oryginal_era(12,1,i,5,:), 1, length(h_oryginal_era(12,1,i,5,:))), 'fro');
%     h_f_e_eps_12(i) = norm(reshape(h_final_era(12,1,i,5,:), 1, length(h_final_era(12,1,i,5,:))) - reshape(h_final_b(12,1,i,5,:), 1, length(h_final_b(12,1,i,5,:))), 'fro');
% end
% 
% figure()
% subplot(3,1,1)
% hold on
% scatter(t,h_f_o_eps_10,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,h_e_o_eps_10,'MarkerFaceColor','r','MarkerEdgeColor','k');
% scatter(t,h_f_e_eps_10,'MarkerFaceColor','g','MarkerEdgeColor','k');
% title('Frobenius parametrów Markova uk³adu 10, dla watortoœci epsilon')
% legend('F-O', 'E-O', 'F-E');xlabel('Próba');ylabel('RMSE');
% grid on
% subplot(3,1,2)
% hold on
% scatter(t,h_f_o_eps_11,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,h_e_o_eps_11,'MarkerFaceColor','r','MarkerEdgeColor','k');
% scatter(t,h_f_e_eps_11,'MarkerFaceColor','g','MarkerEdgeColor','k');
% title('Frobenius parametrów Markova uk³adu 11, dla watortoœci epsilon')
% legend('F-O', 'E-O', 'F-E');xlabel('Próba');ylabel('RMSE');
% grid on
% subplot(3,1,3)
% hold on
% scatter(t,h_f_o_eps_12,'MarkerFaceColor','b','MarkerEdgeColor','k');
% scatter(t,h_e_o_eps_12,'MarkerFaceColor','r','MarkerEdgeColor','k');
% scatter(t,h_f_e_eps_12,'MarkerFaceColor','g','MarkerEdgeColor','k');
% title('Frobenius parametrów Markova uk³adu 12, dla watortoœci epsilon')
% legend('F-O', 'E-O', 'F-E');xlabel('Próba');ylabel('RMSE');
% grid on