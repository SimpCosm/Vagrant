# Vagrant
Vagrantfile For Development Enviroment

## Features
vagrant 虚拟开发环境，和线上环境保持一致，已预装git, vim, python, go, docker等, 并完成以下配置：

- docker 采用阿里云镜像加速
- miniconda-python-3.6.6，pip采用阿里云镜像加速
- vim 语法高亮等常用配置
- git 快捷命令等常用配置
- 系统编码已设置为zh_CN.UTF-8
- 命令搜索自动前缀匹配，历史命令保存100000个
- host文件夹和vm文件夹映射
- 支持自定义硬盘


## Get Started
本地目录下放置Vagrantfile，执行以下命令即可

```bash
vagrant up # 启动虚拟机
vagrant ssh # ssh到虚拟机
vagrant halt  # 关闭虚拟机，通常情况下，无需关闭
```

详细使用方法可参考 https://houmin.cc/posts/ccdd2b68/
