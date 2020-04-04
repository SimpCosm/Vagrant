# Vagrant
Vagrantfile For Development Enviroment

## Features
vagrant 虚拟开发环境，和线上环境保持一致，已预装git, vim, python, go, docker等, 并完成以下配置：

- docker 采用阿里云镜像加速
- miniconda-python-3.6.6，pip采用阿里云镜像加速
- vim 语法高亮等常用配置
- git 快捷命令等常用配置
- 命令搜索自动前缀匹配，历史命令保存100000个
- host文件夹和vm文件夹映射
- 支持自定义硬盘


## Get Started

```
$ git clone git@github.com:SimpCosm/Vagrant.git
$ cd Vagrant
$ mkdir data    # create shared folder, modify it in Vagrantfile as you like
$ vagrant up    # create the virtual machine 
$ vagrant ssh   # ssh to virtual machine
```

详细使用方法可参考 https://houmin.cc/posts/ccdd2b68/
