function [] = exportPdf(figure, fileName)
% set(gcf, 'Position', [100, 100, 1000, 600]);
set(gcf, 'Position', [100 100 1200 500]);
set(figure,'Units','Inches');
pos = get(figure,'Position');
set(figure,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(figure, fileName,'-dpdf','-r0')