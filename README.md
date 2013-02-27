## 安装

Add this line to your application's Gemfile:

  gem 'moode_user_plugin', :git => 'git@github.com:lishoubo/moode_user_plugin.git'

## 使用

首先，执行：

  rails g md_initializer

会做三件事情：

- 将plugin中的migration抽取出来
- 将plugin mount到"/"的path
- 添加默认的plugin配置文件在initializers文件夹下

然后，执行正常的migration即可。  