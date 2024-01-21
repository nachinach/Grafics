#include "animateVertices.h"
#include "glwidget.h"
#include <QCoreApplication>

const int SHADOW_MAP_WIDTH = 512;
const int SHADOW_MAP_HEIGHT = 512;

void AnimateVertices::onPluginLoad()
{
    // Carregar shader, compile & link
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile(glwidget()->getPluginPath()+"/../animateVertices/animateVertices.vert");
    //cout << "vs" << endl;

    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile(glwidget()->getPluginPath()+"/../animateVertices/animateVertices.frag");
    //cout << "fs" << endl;
 
    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    if (!program->isLinked()) cout << "Shader link error" << endl;

    elapsedTimer.start();
}


void AnimateVertices::preFrame()
{
    program->bind();
    QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP);
    program->setUniformValue("normalMatrix", camera()->viewMatrix().normalMatrix());
    program->setUniformValue("time", float(elapsedTimer.elapsed()/1000.0));

}

void AnimateVertices::postFrame()
{
    program->release();
}
