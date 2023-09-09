## lua热更
- 在游戏运行过程中自动加载lua文件

## lua加载文件的机制
- package.loaded 记录已加载的文件
- 如果 文件名 = true 那么不会重复加载
- 只需要将loaded[文件名] = nil 就可以重新加载文件
- 但是w3x2lni打包的时候会把lua文件打包到w3x
- 需要将a.lua不被打包进去 package.path
## 注册按键f5重新加载文件
- 按f5重新加载文件了
## 打包上传平台的时候
- 需要将hotdemo目录里面内容复制到map文件