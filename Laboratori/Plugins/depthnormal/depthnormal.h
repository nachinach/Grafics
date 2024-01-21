#ifndef _DEPTHNORMAL_H
#define _DEPTHNORMAL_H

#include "plugin.h" 

class Depthnormal: public QObject, public Plugin
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "Plugin") 
	Q_INTERFACES(Plugin)

  public:
	 void onPluginLoad();
	 void preFrame();
	 void postFrame();

	 void onObjectAdd();
	 bool drawScene();
	 bool drawObject(int);

	 bool paintGL();

	 void keyPressEvent(QKeyEvent *);
	 void mouseMoveEvent(QMouseEvent *);
  private:
	QOpenGLShaderProgram * depthShaderProgram;
	QOpenGLShader * depthVS, * depthFS;
	QOpenGLShaderProgram * normalShaderProgram;
	QOpenGLShader * normalVS, * normalFS;

	void linkDepthShaders();
	void linkNormalShaders();
};

#endif
