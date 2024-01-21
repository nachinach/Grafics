#ifndef _MODELINFO2_H
#define _MODELINFO2_H

#include "plugin.h"
#include <QPainter>


class ModelInfo2: public QObject, public Plugin
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "Plugin") 
	Q_INTERFACES(Plugin)

  public:
	 void onPluginLoad();
     void onObjectAdd();
     void onObjectLoad();
     void onSceneClear();
     void postFrame() Q_DECL_OVERRIDE;
  private:
	void updateModelInfo();
	QPainter painter;
	int nObj, nPol, nVer, nTri;
};

#endif
