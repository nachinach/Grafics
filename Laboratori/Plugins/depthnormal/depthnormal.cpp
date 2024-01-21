#include "depthnormal.h"
#include "glwidget.h"

void Depthnormal::linkDepthShaders()
{
	depthVS = new QOpenGLShader(QOpenGLShader::Vertex, this);
	depthVS->compileSourceFile("depth.vert");

	depthFS = new QOpenGLShader(QOpenGLShader::Fragment, this);
	depthFS->compileSourceFile("depth.frag");

	depthShaderProgram = new QOpenGLShaderProgram(this);
	depthShaderProgram->addShader(depthVS);
	depthShaderProgram->addShader(depthFS);
	depthShaderProgram->link();

	cout << "Linked Depth Shaders:" << depthShaderProgram->log().toStdString() << endl;
}

void Depthnormal::linkNormalShaders()
{
	normalVS = new QOpenGLShader(QOpenGLShader::Vertex, this);
	normalVS->compileSourceFile("normal.vert");

	normalFS = new QOpenGLShader(QOpenGLShader::Fragment, this);
	normalFS->compileSourceFile("normal.frag");

	normalShaderProgram = new QOpenGLShaderProgram(this);
	normalShaderProgram->addShader(normalVS);
	normalShaderProgram->addShader(normalFS);
	normalShaderProgram->link();

	cout << "Linked Normal Shaders:" << depthShaderProgram->log().toStdString() << endl;
}

void Depthnormal::onPluginLoad()
{
	GLWidget & widget = * glwidget();
	widget.makeCurrent();
	linkDepthShaders();
	linkNormalShaders();
}

void Depthnormal::preFrame()
{
	
}

void Depthnormal::postFrame()
{
	
}

void Depthnormal::onObjectAdd()
{
	
}

bool Depthnormal::drawScene()
{
	return false; // return true only if implemented
}

bool Depthnormal::drawObject(int)
{
	return false; // return true only if implemented
}

bool Depthnormal::paintGL()
{
	GLWidget & widget = * glwidget();
	widget.makeCurrent();
	float ar = (widget.height() / widget.width())/2;
	camera()->setAspectRatio(ar);

	normalShaderProgram->bind();
	QMatrix4x4 MVP = widget.camera()->projectionMatrix() * widget.camera()->viewMatrix();
	normalShaderProgram->setUniformValue("modelViewProjectionMatrix", MVP);

	depthShaderProgram->bind();
	depthShaderProgram->setUniformValue("modelViewProjectionMatrix", MVP);

	widget.defaultProgram()->bind();
	widget.update();
	return true; // return true only if implemented
}

void Depthnormal::keyPressEvent(QKeyEvent *)
{
	
}

void Depthnormal::mouseMoveEvent(QMouseEvent *)
{
	
}

