!/bin/bash

#������������ ������� � ������ (����� ���� �������������� ������������� Ubuntu 18.04 Server)
#��������� ���� � ���������� ���������� ������
$ sudo apt -y update
#��������� ����� (� ����� ���� � � ���������� ����������, ������ ����� ������ � ����� �����) 
$ sudo apt -y install openjdk-8-jdk

#��������� ����� (�� �� � ����� � � ���. ��������� ������)
$ sudo apt -y update
$ sudo apt -y install maven
# ���������� �� ������ (�� ������ �����)
$ mvn -version

# ������ �����-���������� ��� ��������: �������� ����� ��� ����� � ���������� � ���� ��� ����������
$ wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
$ sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
# ��������� ��� �������, �������� ����� ��� ���� � ���������� ����������
$ sudo apt -y update
$ sudo apt install -y jenkins

#������ ������� � ������, �� ���������� �� ���� �������� 8080
$ sudo ufw allow 8080

#������� �������� �������� �� �������
# 192.168.0.10:8080
#�� ������ ������� ��� �������� ������ �������������
#������ ������ �� ������� � ���������
#� 
# $ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
# ������ ������
# 4f423920bd4c403eaf0bcd9cc7eafe4d

#��������� ������, ������ ����� � ������ ������ ������ :-)