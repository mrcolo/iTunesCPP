#include "playlist.h"
#include <QDebug>
#include <QJsonObject>
playlist::playlist()
{

}

void playlist::writeToJson()
{

}

void playlist::readJson()
{
  QString val;
  QFile file;
  file.setFileName("test.json");
  file.open(QIODevice::ReadOnly | QIODevice::Text);
  val = file.readAll();
  file.close();
  qWarning() << val;
  QJsonDocument d = QJsonDocument::fromJson(val.toUtf8());
  QJsonObject sett2 = d.object();
  QJsonValue value = sett2.value(QString("appName"));
  qWarning() << value;
  QJsonObject item = value.toObject();
  qWarning() << "QJsonObject of description: " << item;

  /* in case of string value get value and convert into string*/
  qWarning() << "QJsonObject[appName] of description: " << item["description"];
  QJsonValue subobj = item["description"];
  qWarning() << subobj.toString();

  /* in case of array get array and convert into string*/
  qWarning() << "QJsonObject[appName] of value: " << item["imp"];
  QJsonArray test = item["imp"].toArray();
  qWarning() << test[1].toString();
}
