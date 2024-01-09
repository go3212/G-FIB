#include "isafloor.h"
#include "glwidget.h"
#include <QtMath>

void Isafloor::onPluginLoad()
{
	// Carregar shader, compile & link 
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile(glwidget()->getPluginPath()+"/../isafloor/isafloor.vert");
    cout << "VS log:" << vs->log().toStdString() << endl;

    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile(glwidget()->getPluginPath()+"/../isafloor/isafloor.frag");
    cout << "FS log:" << fs->log().toStdString() << endl;

    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    cout << "Link log:" << program->log().toStdString() << endl;
}

void Isafloor::preFrame()
{
	program->bind();
	QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP); 
    program->setUniformValue("modelViewMatrix", camera()->viewMatrix()); 
    program->setUniformValue("normalMatrix", camera()->viewMatrix().normalMatrix());
	float lambda = calculateLambda();
	program->setUniformValue("lambda", lambda);
	std::cout << lambda << std::endl;
}

void Isafloor::postFrame()
{
	program->release();
}

void Isafloor::onObjectAdd()
{
	
}

bool Isafloor::drawScene()
{
	return false; // return true only if implemented
}

bool Isafloor::drawObject(int)
{
	return false; // return true only if implemented
}

bool Isafloor::paintGL()
{
	return false; // return true only if implemented
}

Vector crossProduct(Vector a, Vector b)
{
	float i = (a.y()*b.z()) - (a.z()*b.y());
	float j = (a.z()*b.x()) - (a.x()*b.z());
	float k = (a.x()*b.y()) - (a.y()*b.x());
	return Vector(i, j, k);
}

float mod(Vector v)
{
	return qSqrt(v.x()*v.x() + v.y()*v.y() + v.z()*v.z());
}

float Surface(Point p1, Point p2, Point p3)
{

	Vector A = p2 - p1;
	Vector B = p3 - p1;
	
	return (mod(crossProduct(A,B)))/2.0f;
}

float dotProduct(Vector a, Vector b)
{
	return a.x()*b.x() + a.y()*b.y() + a.z()*b.z();
}

float Isafloor::calculateLambda() {
	float lambda = 0.0f;
	if (scene()->objects().size() == 1) 
	{
		float supTerra = 0.0;
		float supTotal = 0.0;
		const Object &obj = scene()->objects()[0];
		for (int i = 0; i < obj.faces().size(); i++) {
			int index0 = obj.faces()[i].vertexIndex(0);
			int index1 = obj.faces()[i].vertexIndex(1);
			int index2 = obj.faces()[i].vertexIndex(2);
			Point p0 = obj.vertices()[index0].coord();
			Point p1 = obj.vertices()[index1].coord();
			Point p2 = obj.vertices()[index2].coord();
			
			float sup = Surface(p0, p1, p2);

			Vector norm = obj.faces()[i].normal();
			Vector vec = Vector(0., 0., 1.);
			if (dotProduct(norm, vec) > 0.7)
				supTerra += sup;
			supTotal += sup;
		}
		lambda = (float) supTerra / supTotal;
	}
	return lambda;
}

void Isafloor::keyPressEvent(QKeyEvent *)
{
	
}

void Isafloor::mouseMoveEvent(QMouseEvent *)
{
	
}

