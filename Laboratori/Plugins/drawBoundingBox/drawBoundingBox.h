#ifndef _DRAWBOUNDINGBOX_H
#define _DRAWBOUNDINGBOX_H

#include "plugin.h"

class DrawBoundingBox: public QObject, public Plugin
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
	QOpenGLShaderProgram * program;
	QOpenGLShader * vs, * fs;
	GLuint boxVAO;
	void createBox(GLWidget & widget);
	void linkShaders();
	void drawBox(GLWidget & widget, const Box & box);
};

#endif
