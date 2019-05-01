FROM ubuntu:16.04  #ubuntu:latest cannot work on old kernel(e.g. centos6.5[kernel 2.6]).
ARG mirror_src=0

RUN	if [[ $mirror_src != 0 ]]; then sed -i 's/archive.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list; fi	\
	&& apt-get update			\
	&& apt-get -y install wget	\
	&& apt-get -y install gnupg	\
	&& wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg |  apt-key add -	\
	&& apt-get -y install apt-transport-https	\
	&& echo "deb https://download.sublimetext.com/ apt/stable/" |  tee /etc/apt/sources.list.d/sublime-text.list	\
	&& echo "deb https://download.sublimetext.com/ apt/dev/" |  tee /etc/apt/sources.list.d/sublime-text.list		\
	&& apt-get update	\
	&& apt-get install -y sublime-merge

RUN apt-get install -y git		\
	&& apt-get clean && apt-get autoclean

CMD ["bash", "-c", "smerge & wait"]

