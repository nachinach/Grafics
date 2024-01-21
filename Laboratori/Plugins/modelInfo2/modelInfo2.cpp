#include "modelInfo2.h"
#include "glwidget.h"

void ModelInfo2::updateModelInfo(){
    Scene* scn = scene();
	nObj = scn->objects().size();
    nPol = 0, nVer = 0, nTri = 0;

    for (int i = 0; i<nObj; ++i) {
        const Object& obj = scn->objects()[i];
        int nfaces = obj.faces().size();
        nPol += nfaces;
        for (int j = 0; j<nfaces; ++j) {
            const Face& face = obj.faces()[j];
            nVer += face.numVertices();
            if (face.numVertices()%3 == 0) ++nTri;
        }
    }
}

void ModelInfo2::postFrame(){
    painter.begin(glwidget());
    QFont font;
    font.setPixelSize(15);
    painter.setFont(font);
    //painter.setPen(QColor(255,0,0));
    int x = 20;
    int y = 350;

    painter.drawText(x, y, QString("INFO:"));
    painter.drawText(x, y+20, QString(" - Objectes: %1").arg(nObj));
    painter.drawText(x, y+40, QString(" - Polígons: %1").arg(nPol));
    painter.drawText(x, y+60, QString(" - Vèrtexs: %1").arg(nVer));
    painter.drawText(x, y+80, QString(" - Triangles: %1").arg(nTri));
    if (nPol!=0) painter.drawText(x, y+100, QString(" - Percentatge de triangles: %1%").arg(double(nTri/nPol) * 100));
    else painter.drawText(x, y+100, QString(" - Percentatge de triangles: NULL"));
    painter.end();
}

void ModelInfo2::onPluginLoad()
{
    updateModelInfo();
}

void ModelInfo2::onObjectAdd()
{
    updateModelInfo();
}

void ModelInfo2::onObjectLoad()
{
    updateModelInfo();
}

void ModelInfo2::onSceneClear()
{
    updateModelInfo();
}
